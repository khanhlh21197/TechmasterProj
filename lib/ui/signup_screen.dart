import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'file:///D:/KhanhLH/techmaster_lesson_2/lib/model/user.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    nameController.dispose();
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
        title: Text("Đăng ký"),
        centerTitle: true,
      ),
      key: _scaffoldKey,
      body: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          child: buildBody(),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        SingleChildScrollView(
          child: Expanded(
            child: Column(
              children: [
                SizedBox(height: 64),
                Image.asset(
                  'assets/logo.png',
                  width: 128,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16),
                buildTextField('Họ tên', Icon(Icons.person), TextInputType.text,
                    nameController),
                SizedBox(height: 16),
                buildTextField('Số điện thoại', Icon(Icons.phone_android),
                    TextInputType.text, phoneController),
                SizedBox(height: 16),
                buildTextField('Mật khẩu', Icon(Icons.vpn_key),
                    TextInputType.text, passwordController,
                    obscureText: true),
                SizedBox(height: 16),
                buildTextField('Email', Icon(Icons.email), TextInputType.text,
                    emailController),
                SizedBox(height: 16),
                buildTextField('Địa chỉ', Icon(Icons.location_city),
                    TextInputType.text, addressController),
                SizedBox(height: 16),
                buildButton(),
              ],
            ),
          ),
        ),
        // buildHotline(),
        buildHotline2(),
        SizedBox(height: 20),
      ],
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
        obscureText: obscureText,
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
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 36,
          margin: EdgeInsets.only(right: 30),
          child: RaisedButton(
            onPressed: () {
              String phone = phoneController.text;
              String name = nameController.text;
              String password = passwordController.text;
              String email = emailController.text;
              String address = addressController.text;
              register(phone, name, password, email, address);
            },
            child: Text(
              'Đăng ký',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
          ),
        )
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
    return RichText(
      text: TextSpan(children: [
        TextSpan(text: 'HotLine: ', style: TextStyle(color: Colors.black)),
        TextSpan(text: '1900.1008', style: TextStyle(color: Colors.blue)),
      ]),
    );
  }

  Future<http.Response> register(String phone, String name, String password,
      String email, String address) async {
    if (phone.isNotEmpty && name.isNotEmpty && password.isNotEmpty) {
      print('$phone - $name - $password');
      final user = User(
          name: name,
          phone: phone,
          password: password,
          email: email,
          address: address);
      final response = await http.put(
          'http://report.bekhoe.vn/api/accounts/Register',
          body: user.toJson());
      print(response);
      Navigator.pop(context, user);
    } else {
      Scaffold.of(_scaffoldKey.currentContext).showSnackBar(
        SnackBar(
          content: Text("Vui lòng nhập đủ thông tin"),
        ),
      );
    }
  }
}
