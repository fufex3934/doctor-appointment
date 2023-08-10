import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
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
