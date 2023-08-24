import 'package:doctor/view/Chating/send_message.dart';
import 'package:doctor/view/Chating/retrieve_message.dart';
import 'package:doctor/view/customer_support.dart';
import 'package:flutter/foundation.dart';

import 'package:doctor/view/4Patient/profile.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'controller/Provider.dart';
import 'view/splashPage/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//   options: DefaultFirebaseOptions.currentPlatform,
// );

void main() async {
  //for the fire base setup
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // till this line dont touch it
  runApp(
    ChangeNotifierProvider(
      create: (context) => PatientProvider(),

      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyApp()), // Your app's root widget
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    //*****************************
    // return MaterialApp(
    //   title: 'Chat App',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),home: UserListPage(),
    //   home: DefaultTabController(
    //     length: 2,
    //     child: Scaffold(
    //       appBar: AppBar(
    //         title: Text('Chat App'),
    //         bottom: TabBar(
    //           tabs: [
    //             Tab(text: 'Send Message'),
    //             Tab(text: 'Retrieve Messages'),
    //           ],
    //         ),
    //       ),
    //       body:UserListPage(),
    //       // TabBarView(
    //       //   children: [
    //       //     UserListPage(),
    //       //     //SendMessageScreen(), // Use the send message screen
    //       //     //RetrieveMessageScreen(), // Use the retrieve message screen
    //       //   ],
    //       // ),
    //     ),
    //   ),
    // );
    // //*********************

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
