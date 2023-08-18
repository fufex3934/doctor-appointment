import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RetrieveMessageScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void deleteMessage(String messageId) async {
    await _firestore.collection('messages').doc(messageId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrieve Messages'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final messages = snapshot.data!.docs;
          List<Widget> messageWidgets = [];
          for (var message in messages) {
            final messageId = message.id;
            final sender = message['sender'];
            final content = message['content'];

            final messageWidget = ListTile(
              title: Text('$sender: $content'),
              trailing: ElevatedButton(
                onPressed: () {
                  deleteMessage(messageId);
                },
                child: Text('Delete'),
              ),
            );

            messageWidgets.add(messageWidget);
          }

          return ListView(
            children: messageWidgets,
          );
        },
      ),
    );
  }
}
