import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  final String selectedOption;
  const ResetPasswordPage(
      {Key? key, required this.email, required this.selectedOption})
      : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _passwordsMatch = true;
  bool _isPasswordValid = false;

  Future<void> showModal(String title, String content) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> doctorsLogin() async {
    final response = await http.post(
      Uri.parse(
          'http://localhost:3000/users/ForgotPassword/${widget.selectedOption}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'email': widget.email, 'newPassword': _newPasswordController.text}),
    );

    return response.body == "true";
  }

  void _validatePasswords() {
    setState(() {
      _passwordsMatch =
          _newPasswordController.text == _confirmPasswordController.text;

      // Additional password validation checks
      _isPasswordValid = _newPasswordController.text.isNotEmpty &&
          _newPasswordController.text.length >= 8 &&
          _newPasswordController.text
              .contains(RegExp(r'[A-Z]')) && // At least one capital letter
          _newPasswordController.text
              .contains(RegExp(r'[a-z]')); // At least one small letter
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 200.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _newPasswordController,
                onChanged: (_) => _validatePasswords(),
                decoration: InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Enter Your New Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _confirmPasswordController,
                onChanged: (_) => _validatePasswords(),
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm Your New Password',
                  border: OutlineInputBorder(),
                  errorText: _passwordsMatch
                      ? (_isPasswordValid
                          ? null
                          : 'Password must be at least 8 characters and contain at least one capital letter and one small letter'
                          )
                      : 'Passwords do not match',
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_passwordsMatch && _isPasswordValid) {
                    bool passwordChanged = await doctorsLogin();
                    if (passwordChanged == true) {
                      // Password update successful
                      showModal('Password Updated',
                          'Your Password has been updated Successfully!');
                    } else if (passwordChanged == false) {
                      // Password update failed
                      showModal('Password Update Failed',
                          'Failed to update password. Please try again.');
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Change Password',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
