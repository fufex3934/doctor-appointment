import 'package:doctor/view/Chating/chat_service.dart';
import 'package:doctor/view/Chating/home_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  final String receiver;
  final String receiverEmail;
  final String receiverUserId;
  const ChatPage(
  {
    super.key,
    required this.receiver,
    required this.receiverEmail,
    required this.receiverUserId,

}



      );
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatService _chatService=ChatService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _messageController = TextEditingController();

  void sendMessage(String messageContent) async {
    if (messageContent.isNotEmpty) {
      final newDocumentRef = _firestore.collection('messages').doc(); // Generate a new document reference with an auto-generated UID
      await newDocumentRef.set({
        'sender': 'kenean  two',
        'senderid': "senderUserID1",
        'email':'negaamauel387@gmail.com',
        "receiveremail":"asebekalu@gmail.com",
        'content': messageContent,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiver),
      ),
      body: Column(
        children: [
          Expanded(


            //this part will bring the message from the firestore

            //********************************

            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .where('senderid', isEqualTo: 'senderUserID1')
                  .where('receiveremail', isEqualTo: 'negaamauel387@gmail.com')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages = snapshot.data!.docs;
                List<Widget> messageWidgets = [];
                for (var message in messages) {
                  final sender = message['sender'];
                  final content = message['content'];
                  final isCurrentUser = sender == 'kenean  two';

                  final messageWidget = ListTile(
                    title: Align(
                      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: isCurrentUser ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(content),
                      ),
                    ),
                  );

                  messageWidgets.add(messageWidget);
                }

                return ListView(
                  children: messageWidgets,
                );
              },
            ),



            //******************************************************
          ),
          Container(
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Enter your message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(_messageController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//build message Item

