import 'dart:convert';

import 'package:doctor/controller/Provider.dart';
import 'package:doctor/model/listCategory.dart';
import 'package:doctor/view/4Doctor/today_appointments.dart';
import 'package:doctor/view/4Patient/BookAppointment/bookAppointment.dart';
import 'package:doctor/view/4Patient/Category/CategoryChoose.dart';
import 'package:doctor/view/Registration_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
 
import 'package:provider/provider.dart';
 
import './forgot_password.dart';
 

class LoginPage extends StatefulWidget {
  static const routeName = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String selectedOption = "Doctor";
  bool authenticated = false;
  int currentPageIndex = 0;
  String _email = '';
  String _password = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<bool> DoctorsLogin() async {
      final response = await http.post(
          Uri.parse('http://192.168.0.169:3000/users/Login/${selectedOption}'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': _email, 'password': _password}));

      return (response.body == 'true');
    }
    final patentProvider = Provider.of<PatientProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Avoid the keyboard overlaying the content
      body: Form(
        key: _formKey,
        child: ListView(
          padding:
              const EdgeInsets.only(left: 20.0, right: 20, top: 100, bottom: 0),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedOption = "Doctor";
                      currentPageIndex = 0;
                    });
                  },
                  child: Text(
                    "Doctor",
                    style: TextStyle(
                        fontSize: selectedOption == "Doctor" ? 25 : 20,
                        color: selectedOption == "Doctor"
                            ? Colors.blue
                            : Colors.black),
                  ),
                ),
                Container(
                  width: 2, // Width of the vertical line
                  height: 20, // Height of the vertical line
                  color: Colors.grey, // Color of the vertical line
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        selectedOption = "Patient";
                        currentPageIndex = 1;
                      });
                    },
                    child: Text(
                      "Patient",
                      style: TextStyle(
                          fontSize: selectedOption == "Patient" ? 25 : 20,
                          color: selectedOption == "Patient"
                              ? Colors.blue
                              : Colors.black),
                    )),
              ],
            ),
            const Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 20),
                child: Text(
                  "Login Page",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Email",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "Enter Your Email",
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                // Add email format validation here if needed
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Password",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Enter Your Password",
                prefixIcon: Icon(Icons.lock),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                // Add password complexity validation here if needed
                return null;
              },
              onSaved: (value) {
                _password = value!;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // print(
                //     'Login Return from authentication ====> ${authenticated}');
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  bool authenticated = await DoctorsLogin();

                  if (authenticated) {
                    print(authenticated);
                    switch (selectedOption) {
                      case "Doctor":
                       
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TodayAppointments()));
                        break;
                      case "Patient":
                       patentProvider.setPatient(Patient(fullname: "Patient", email: _email));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryChoice()));
                        break;
                      default:
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("Please Check your Email or Password"),
                            shape: Border.all(
                                color: Colors.red,
                                style: BorderStyle.solid,
                                width: 2),
                            duration: Duration(milliseconds: 1500),
                          ),
                        );
                    }
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff1e40af),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordPage(selectedOption:selectedOption)));
              },
              child: const Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LandingPage()));
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.blue, // Set your desired color
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
