import 'package:flutter/material.dart';

import 'ui/login_screen.dart';

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
