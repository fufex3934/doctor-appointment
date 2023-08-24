import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  final String senderEmail;
  final String senderId;
  final String recieverEmail;
  final String recieverId;

  ChatPage(
      {required this.senderEmail,
      required this.senderId,
      required this.recieverEmail,
      required this.recieverId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<String> messages = [];

  TextEditingController messageController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<dynamic> _list = [];
// Sending a message
  Future<void> _sendMessage() async {
    if (messageController.text.trim().isNotEmpty) {
      // setState(() {
      //   messages.add(messageController.text);
      //   messageController.clear();
      // });

      print(
          "Data when sending message ${messageController.text} ${widget.senderId} ${widget.senderEmail}");

      try {
        DocumentReference docRef = await firestore.collection('messages').add({
          'text': messageController.text,
          'senderUid':
              widget.senderId, // Use the UID from your custom authentication
          'senderEmail': widget
              .senderEmail, // Use the email from your custom authentication
          'timestamp': FieldValue.serverTimestamp(),
          "toId": widget.recieverId,
          "toEmail": widget.recieverEmail
        });

        if (docRef != null) {
          // Document added successfully
          print("Document added with ID: ${docRef.id}");
        } else {
          // Document was not added successfully
          print("Failed to add document");
        }
      } catch (err) {
        print(err);
      }
    } else {
      print("message is empty"); //TODO: add snackbar message to show this error
    }
  }

  // recieve a message

  Stream<QuerySnapshot<Map<String, dynamic>>> _getAllMessage(String id) {
    return firestore
        .collection('messages')
        .where('toId', isEqualTo: id)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              // Open a dialog with chat information or settings
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Chat Information'),
                    content: Text(
                        'This chat is for communication between patient and  doctor.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _getAllMessage(widget.recieverId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Handle loading state
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}'); // Handle error state
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return Text('No messages'); // Handle no data state
                }

                final data = snapshot.data!.docs;

                _list = data
                    .map((doc) => doc.data() as Map<String, dynamic>)
                    .toList();

                return ListView.builder(
                  reverse: true,
                  itemCount: _list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          _list[index]['text'] as String,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      trailing: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
