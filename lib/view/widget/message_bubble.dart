import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String text;

  MessageBubble({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 6.0,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          child: Text(text, style: TextStyle(fontSize: 15, color: Colors.black)),
        ),
      ),
    );
  }
}
