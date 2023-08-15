import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SendMessageScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(BuildContext context, String messageContent) async {
    try {
      final newDocumentRef = _firestore.collection('messages').doc(); // Generate a new document reference with an auto-generated UID
      await newDocumentRef.set({
        'sender': 'kenean two',
        'email':'negaamauel387@gmail.com',
        "receiveremail":"asebekalu@gmail.com",
        'content': messageContent,
        'timestamp': FieldValue.serverTimestamp(),
      });;

      // Display a success message here if needed
    } catch (e) {
      // Display an error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error Sending Message'),
            content: Text('An error occurred while sending the message.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Message'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                sendMessage(context, 'while checking the uid '); // Specify your message content
              },
              child: Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}