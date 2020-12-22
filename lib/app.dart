import 'package:flutter/material.dart';
import 'package:techmaster_lesson_2/ui/login_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.orange),
      // home: LayoutScreen(),
      home: LoginScreen(),
    );
  }
}

//device info
//package info
//url launcher
//image picker
//web view
//shared preferences
//convert date time
//http

//lottie
