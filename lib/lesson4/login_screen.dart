import 'package:flutter/material.dart';
import 'package:techmaster_lesson_2/lesson4/home_screen.dart';
import 'package:techmaster_lesson_2/navigator.dart';
import 'package:techmaster_lesson_2/utilities/shared_preferences_manager.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      child: Center(
        child: RaisedButton(
          onPressed: () {
            sharedPreferences.saveString(key: tokenKey, value: 'abc');
            navigatorPushAndRemoveUntil(context, HomeScreen());
          },
          child: Text('Init data'),
        ),
      ),
    );
  }
}
