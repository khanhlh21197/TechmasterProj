import 'package:flutter/material.dart';
import 'package:techmaster_lesson_2/ui/account_screen.dart';
import 'package:techmaster_lesson_2/ui/change_password_screen.dart';
import 'package:techmaster_lesson_2/ui/contact_screen.dart';
import 'package:techmaster_lesson_2/ui/home_screen.dart';
import 'package:techmaster_lesson_2/ui/signup_screen.dart';

import 'file:///D:/KhanhLH/techmaster_lesson_2/lib/model/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Đăng nhập"),
        centerTitle: true,
      ),
      body: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: buildBody(),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Container(
      child: Column(
        children: [
          Expanded(
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
                    TextInputType.visiblePassword, passwordController),
                SizedBox(height: 16),
                buildButton(),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen()));
                  },
                  child: Text('Doi mat khau'),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AccountScreen()));
                  },
                  child: Text('Account'),
                ),
              ],
            ),
          ),
          buildHotline2(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildTextField(String labelText, Icon prefixIcon,
      TextInputType keyboardType, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 44,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        autocorrect: false,
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ContactScreen()));
      },
      child: RichText(
        text: TextSpan(children: [
          TextSpan(text: 'HotLine: ', style: TextStyle(color: Colors.black)),
          TextSpan(text: '1900.1008', style: TextStyle(color: Colors.blue)),
        ]),
      ),
    );
  }

// Future<http.Response> login(){
//   return http.get(url)
// }
}
