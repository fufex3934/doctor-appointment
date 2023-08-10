import 'package:flutter/material.dart';
import './reset_password.dart';
class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool otpSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 200.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Forgot Your Password?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Text(
              'Enter your registered email to receive an OTP.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter Your Registered Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  otpSent = true;
                });
                // Logic to send OTP
              },
              child: Text('Send OTP'),
            ),
            if (otpSent) ...[
              SizedBox(height: 20),
              Text('An OTP has been sent to your email. Please enter it below.',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter OTP You Receive From Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(
                    builder:(context)=>ResetPasswordPage()
                  ),
                  );
                  // Logic to verify OTP and reset password
                },
                child: Text('Confirm'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
