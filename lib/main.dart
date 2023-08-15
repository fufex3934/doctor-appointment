import 'package:doctor/view/4Patient/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'controller/Provider.dart';
import 'view/splashPage/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PatientProvider(),
      child: MaterialApp(home: MyApp()), // Your app's root widget
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        // '/home': (context) => Homepage(),
      },
    );
  }
}
