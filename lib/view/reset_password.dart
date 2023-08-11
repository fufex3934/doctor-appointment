import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPasswordPage extends StatefulWidget {
  final String email;
  final String selectedOption;
  const ResetPasswordPage(
      {super.key, required this.email, required this.selectedOption});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  String _newPassword = '';

  Future<bool> DoctorsLogin() async {
    final response = await http.post(
        Uri.parse(
            'http://192.168.0.150:3000/users/ForgotPassword/${widget.selectedOption}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': widget.email, 'newPassword': _newPassword}));

    return (response.body == 'true');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 200.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Center(
          child: Text(
            'Reset Password',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 20),
        Text(
          'New Password',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Enter Your New Password',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Confirm Password',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Confirm Your New Password',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Logic to send OTP
          },
          child: Text('Change Password'),
        ),
      ]),
    ));
  }
}
