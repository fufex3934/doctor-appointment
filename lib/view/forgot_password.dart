import 'package:flutter/material.dart';
import './reset_password.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:otp/otp.dart';
import 'package:randomstring_dart/randomstring_dart.dart';

class ForgotPasswordPage extends StatefulWidget {
  final selectedOption;
  const ForgotPasswordPage({required this.selectedOption});
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}
//TODO: complete otp sending process through email to user 
class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool otpSent = false;
  String email = '';
  TextEditingController _emailController = TextEditingController();

  Future<void> sendOtpEmail(String userEmail, String otpCode) async {
    final smtpServer = gmail('your.email@gmail.com', 'yourpassword');

    final message = Message()
      ..from = Address('asebekalu@gmail.com', 'Doctor-Patient-App')
      ..recipients.add(userEmail)
      ..subject = 'Password Reset OTP'
      ..text = 'Your OTP code is: $otpCode Please Enter it Space Provided';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ${sendReport.toString()}');
    } catch (e) {
      print('Error sending email: $e');
    }
  }

  final rs = RandomString();

  //otp email sender for password reset
  void requestPasswordReset(String userEmail) {
    // Generate a random OTP code (you can use a package like 'random_string' for this)
    String otpCode = rs.getRandomString();

    // Send the OTP code to the user's email
    sendOtpEmail(userEmail, otpCode);

    // You can also store the OTP code in your backend for verification later
    // For example, update the user's record in your database with the OTP code
  }

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
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Enter OTP You Receive From Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  requestPasswordReset(email); //if sent navigate render enter otp input field
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetPasswordPage(
                            email: _emailController.text,
                            selectedOption: widget.selectedOption)),
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
