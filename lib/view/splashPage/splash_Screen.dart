import 'package:doctor/view/Registration_page.dart';
import 'package:flutter/material.dart';

import '../login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'lib/assets/images/bg3.webp',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            right: -80,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              child: Image.asset(
                'lib/assets/images/image3.png',
                fit: BoxFit.fitHeight,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
