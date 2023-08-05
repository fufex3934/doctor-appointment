import 'view/4Patient/patient_Registration.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute:PatientRegistration.routeName,
      routes: {
        // '/': (context) => const SplashScreen(),
        // DoctorPage.routeName: (ctx) => const DoctorPage(),
        PatientRegistration.routeName:(ctx)=>const PatientRegistration()
      },
    );
  }
}
