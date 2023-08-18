import 'package:doctor/view/Chating/model/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create a new message
  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = '34rbb344hbb3';
    final String currentEmail = 'aaa@gmail.com';
    final Timestamp timestamp = Timestamp.now();
//create a new message

    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);
    //construct chat room id from current user id and receiver id
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("-");
    //add new message to database

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages two')
        .add(newMessage.toMap());
  }

  //Get Messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String ChatRoomId = ids.join();
    return _firestore
        .collection("chat_rooms")
        .doc(ChatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
