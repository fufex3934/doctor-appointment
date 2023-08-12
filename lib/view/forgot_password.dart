import 'dart:convert';

import 'package:flutter/material.dart';
import './reset_password.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:otp/otp.dart';
import 'package:randomstring_dart/randomstring_dart.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:doctor/view/Registration_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  final selectedOption;
  const ForgotPasswordPage({required this.selectedOption});
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

//TODO: complete otp sending process through email to user
class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool otpSent = false;
  String email = '';
  String generatedOtpCode = '';

  TextEditingController _emailController = TextEditingController();
  TextEditingController _otpCodeController = TextEditingController();

  // Future<void> sendOtpEmail(String userEmail, String otpCode) async {
  //   final smtpServer = gmailSaslXoauth2('asebekalu@gmail.com',
  //       'Kuzycidecpahnuwv'); //TODO:save the password to env

  //   final message = Message();

  //   message.from = Address('asebekalu@gmail.com');
  //   message.recipients.add('asebekalu@gmail.com');
  //   message.subject = 'Password Reset OTP';
  //   message.text =
  //       'Your OTP code is: ${otpCode} Please Enter it Space Provided';

  //   try {
  //     final sendReport = await send(message, smtpServer);
  //     print('Message sent: ${sendReport.toString()}');
  //   } catch (e) {
  //     print('Error sending email: $e');
  //   }
  // }
  Future<void> sendOtpEmail(String userEmail, String otpCode) async {
    final smtpServer = SmtpServer(
      'smtp.gmail.com',
      username: 'asebekalu@gmail.com',
      password: 'Kuzycidecpahnuwv',
      port: 465,
      ssl: true,
    );

    final message = Message()
      ..from = Address('asebekalu@gmail.com')
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

  Future<bool> ValidateEmail() async {
    final response = await http.post(
        Uri.parse('http://localhost:3000/users/ForgotPassword/checkEmail'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _emailController.text,
          'selectedOption': widget.selectedOption
        }));
    // print(_emailController.text);
    // print(widget.selectedOption);

    return (response.body == 'true');
  }

  final rs = RandomString();

  //otp email sender for password reset
  void requestPasswordReset(String userEmail) {
    // Generate a random OTP code (you can use a package like 'random_string' for this)
    setState(() {
      generatedOtpCode = rs.getRandomString();
    });

    // Send the OTP code to the user's email
    sendOtpEmail(userEmail, generatedOtpCode);

    // You can also store the OTP code in your backend for verification later
    // For example, update the user's record in your database with the OTP code
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 200.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Registered Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Add more validation logic if needed
                    return null;
                  },
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LandingPage()));
                    },
                    child: Text("Register ?")),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState!.save(); // Trigger onSaved callback
                    print(_emailController
                        .text); // Print the email entered by the user
                    if (_formKey.currentState!.validate()) {
                      bool userFound = await ValidateEmail();
                      print("User Found is ==>${userFound}");
                      if (userFound == true) {
                        requestPasswordReset(_emailController.text);
                        setState(() {
                          otpSent = true;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "User not Found , please Check your Email or Register"),
                            duration: Duration(milliseconds: 1500)));
                      }
                    }
                  },
                  child: Text('Send OTP'),
                ),
                if (otpSent) ...[
                  SizedBox(height: 20),
                  Text(
                      'An OTP has been sent to your email. Please enter it below.',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _otpCodeController,
                    decoration: InputDecoration(
                      labelText: 'Enter OTP You Receive From Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the OTP';
                      }
                      // Add more validation logic if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (generatedOtpCode == _otpCodeController.text) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResetPasswordPage(
                                email: _emailController.text,
                                selectedOption: widget.selectedOption,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("Please Enter OTP Sent to Your Email"),
                              duration: Duration(milliseconds: 1500)));
                        }
                      }
                    },
                    child: Text('Confirm'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
