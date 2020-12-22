import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:techmaster_lesson_2/model/login_response.dart';
import 'package:techmaster_lesson_2/model/user.dart';
import 'package:techmaster_lesson_2/ui/home_screen.dart';
import 'package:techmaster_lesson_2/ui/signup_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../loader.dart';
import '../navigator.dart';
import '../shared_prefs_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  SharedPrefsHelper sharedPrefs;
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    sharedPrefs = SharedPrefsHelper();
    getSharedPrefsValue();
    super.initState();
  }

  void getSharedPrefsValue() async {
    phoneController.text = await sharedPrefs.getStringValuesSF('phone');
    passwordController.text = await sharedPrefs.getStringValuesSF('pass');
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: SafeArea(
                child: buildBody(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 64),
                  Image.asset(
                    'assets/logo.png',
                    width: 128,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  buildTextField('Số điện thoại', Icon(Icons.phone_android),
                      TextInputType.text, phoneController),
                  SizedBox(height: 16),
                  buildTextField('Mật khẩu', Icon(Icons.vpn_key),
                      TextInputType.visiblePassword, passwordController,
                      obscureText: true),
                  SizedBox(height: 16),
                  buildButton(),
                ],
              ),
            ),
          ),
          buildHotline2(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildTextField(String labelText, Icon prefixIcon,
      TextInputType keyboardType, TextEditingController controller,
      {bool obscureText = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 44,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        autocorrect: false,
        obscureText: obscureText,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          labelText: labelText,
          // labelStyle: ,
          // hintStyle: ,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 20,
          ),
          // suffixIcon: Icon(Icons.account_balance_outlined),
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }

  Widget buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FlatButton(
            onPressed: () async {
              User user = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpScreen(),
                ),
              );
              phoneController.text = user.phone;
              passwordController.text = user.password;
            },
            child: Text('Đăng ký')),
        Container(
          height: 36,
          child: RaisedButton(
            onPressed: () {
              var user = User(
                  name: '',
                  phone: phoneController.text,
                  password: passwordController.text,
                  email: '',
                  address: '',
                  userName: '');
              tryLogin(user.toJson());
            },
            child: Text(
              'Đăng nhập',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget buildHotline() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: Text('HotLine fasdf adsf asd fa ds ')),
        Flexible(
            child: Text(
          '1800.1234',
          style: TextStyle(color: Colors.green),
        )),
        Flexible(child: Text('HotLine fasdf adsf asd fa ds ')),
      ],
    );
  }

  Widget buildHotline2() {
    const url = 'tel:19001008';
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: RichText(
        text: TextSpan(children: [
          TextSpan(text: 'HotLine: ', style: TextStyle(color: Colors.black)),
          TextSpan(text: '1900.1008', style: TextStyle(color: Colors.blue)),
        ]),
      ),
    );
  }

  Future<void> tryLogin(Map json) async {
    showLoadingDialog();
    final response = await http
        .post('http://report.bekhoe.vn/api/accounts/login', body: json);
    print('_LoginScreenState.login: ${response.body}');
    print('_LoginScreenState.login: ${jsonDecode(response.body)}');
    hideLoadingDialog();

    final loginResponse = loginResponseFromJson(response.body);
    print('_LoginScreenState.tryLogin ${loginResponse.code}');
    if (loginResponse.code == 0) {
      await sharedPrefs.addStringToSF('phone', phoneController.text);
      await sharedPrefs.addStringToSF('pass', passwordController.text);

      await sharedPrefs.addStringToSF('token', loginResponse.data.token);
      navigatorPush(context, HomeScreen(userResponse: loginResponse.data));
    } else {
      showAlertDialog(context, loginResponse.message);
    }
  }

  void showLoadingDialog() {
    Dialogs.showLoadingDialog(context, _keyLoader);
  }

  void hideLoadingDialog() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  showAlertDialog(BuildContext context, String content) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Thông báo"),
      content: Text(content),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
