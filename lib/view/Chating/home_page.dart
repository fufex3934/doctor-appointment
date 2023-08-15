import 'package:doctor/view/Chating/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserListPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index].data() as Map<String, dynamic>;
              var receiver=user['sender'];


              return ListTile(

                title: Text(user['sender']),
                subtitle: Text(user['content'] ?? ''),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(
                    receiver: user['sender'], receiverEmail: '', receiverUserId: '',

                  )));
                  // Handle tapping on a user if needed
                },
              );
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserListPage(),
  ));
}
