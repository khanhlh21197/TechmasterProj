import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:techmaster_lesson_2/format.dart';
import 'package:techmaster_lesson_2/lesson4/home_screen.dart';
import 'package:techmaster_lesson_2/lesson4/login_screen.dart';
import 'package:techmaster_lesson_2/lesson4/photo_screen.dart';
import 'package:techmaster_lesson_2/lesson4/web_view_screen.dart';
import 'package:techmaster_lesson_2/navigator.dart';
import 'package:techmaster_lesson_2/utilities/shared_preferences_manager.dart';
import 'package:techmaster_lesson_2/utilities/string.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchingScreen extends StatefulWidget {
  @override
  _LaunchingScreenState createState() => _LaunchingScreenState();
}

class _LaunchingScreenState extends State<LaunchingScreen> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  Future<void> initData() async {
    await sharedPreferences.init();

    final token = sharedPreferences.getString(key: tokenKey);
    print('_LaunchingScreenState.initData $token');
    if (token.isNullOrEmpty()) {
      navigatorPush(context, LoginScreen());
    } else {
      navigatorPush(context, HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Device info'),
              onPressed: () async {
                // getDeviceInfo();
                // getPakageInfo();
                first().then((value) {
                  print('$value');
                }).catchError((onError) {
                  print('Catch Error: $onError');
                });
                second();
              },
            ),
            RaisedButton(
              child: Text('Launch url'),
              onPressed: () async {
                _launchURL();
              },
            ),
            RaisedButton(
              child: Text('Web View'),
              onPressed: () async {
                _webView();
              },
            ),
            RaisedButton(
              child: Text('Date time'),
              onPressed: () async {
                _convert();
              },
            ),
            RaisedButton(
              child: Text('Photo'),
              onPressed: () async {
                goToPhoto();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final info = await deviceInfo.androidInfo;
      print('${info.androidId}');
      print('${info.fingerprint}');
      print('${info.hardware}');
      print('${info.model}');
      print('${info.product}');
      print('${info.version}');
      print('${info.id}');
    } else if (Platform.isIOS) {
      final info = await deviceInfo.iosInfo;
      print('${info.model}');
    }
  }

  Future getPakageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    print('$appName - $packageName - $version - $buildNumber');
  }

  Future<String> first() async {
    String number = '12a';
    int result;
    await Future.delayed(
      Duration(seconds: 3),
    );
    try {
      result = int.parse(number);
      return Future.value('$result');
    } catch (e) {
      Future.error('jljljlk');
    }
    print('_LaunchingScreenState.first');
  }

  void second() {
    print('_LaunchingScreenState.second');
  }

  _launchURL() async {
    // const url = 'https://flutter.dev';
    // const url = 'mailto:lek21197@gmail.com';
    // const url = 'tel:0963003197';
    const url = 'https://zalo.me/0963003197';
    // const url = 'mailto:lek21197@gmail.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _webView() async {
    const url = 'https://flutter.dev';
    // const url = 'mailto:lek21197@gmail.com';
    // const url = 'tel:0963003197';
    // const url = 'https://zalo.me/0963003197';
    // const url = 'mailto:lek21197@gmail.com';
    navigatorPush(
        context,
        WebViewScreen(
          title: 'WebView',
          url: url,
        ));
  }

  void _convert() {
    final now = DateTime.now();
    print('$now');
    print('${stringFromDate(now)}');

    final dateOfBirthString = '29/02/2020';
    final date = dateFromString(dateOfBirthString, format: 'dd/MM/yyyy');
    print('$date');
  }

  void goToPhoto() {
    navigatorPush(context, PhotoScreen());
  }
}
