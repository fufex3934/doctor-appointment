import 'package:doctor/view/Chating/send_message.dart';
import 'package:doctor/view/Chating/retrieve_message.dart';
import 'package:doctor/view/customer_support.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'controller/Provider.dart';
import 'view/splashPage/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:doctor/view/Chating/chat_page.dart';
import 'package:doctor/view/Chating/home_page.dart';
void main() async {

  //for the fire base setup
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options:FirebaseOptions(apiKey: "AIzaSyD1ZGbsknSkymMIPH7vl1bQZXuIYSi5-yA", appId: "1:716935647088:web:27a8a63565ad566e7649b5", messagingSenderId: "716935647088", projectId: "second-trial-95f12") );
  }

  await Firebase.initializeApp();

  // till this line dont touch it
  runApp(

    ChangeNotifierProvider(
      create: (context) => PatientProvider(),
      child: MyApp(),
      // Your app's root widget
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(

        SystemUiOverlayStyle(statusBarColor: Colors.transparent));


    //*****************************
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),home: UserListPage(),
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


    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: 'My App',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //     visualDensity: VisualDensity.adaptivePlatformDensity,
    //   ),
    //   initialRoute: '/',
    //   routes: {
    //     '/': (context) => SplashScreen(),
    //     // '/home': (context) => Homepage(),
    //   },
     );
  }
}
