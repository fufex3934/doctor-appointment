import 'package:doctor/view/4Doctor/today_appointments.dart';
import 'package:doctor/view/4Patient/Category/CategoryChoose.dart';
import 'package:doctor/view/Registration_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const routeName = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String selectedOption = "Doctor";
  List<String> options = ["Doctor", "Patient"];
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _email = '';
    String _password = '';

    return Scaffold(

    );
  }
}
