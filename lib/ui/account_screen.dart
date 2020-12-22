import 'package:flutter/material.dart';
import 'package:techmaster_lesson_2/model/login_response.dart';

class AccountScreen extends StatefulWidget {
  final Data userResponse;

  const AccountScreen({Key key, this.userResponse}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  static const API_URL = 'http://report.bekhoe.vn';
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.userResponse.name;
    dobController.text = widget.userResponse.dateOfBirth;
    addressController.text = widget.userResponse.address;
    emailController.text = widget.userResponse.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Tài khoản"),
        centerTitle: true,
      ),
      body: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            child: buildBody(),
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        SizedBox(height: 25),
        buildImage(),
        SizedBox(
          height: 30,
        ),
        buildTextField('Họ & tên', nameController),
        SizedBox(
          height: 15,
        ),
        buildTextField('Ngày sinh', dobController),
        SizedBox(
          height: 15,
        ),
        buildTextField('Địa chỉ', addressController),
        SizedBox(
          height: 15,
        ),
        buildPhoneText(),
        SizedBox(
          height: 15,
        ),
        buildTextField('Email', emailController),
        SizedBox(
          height: 30,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: RaisedButton(
            child: Text(
              'Lưu',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.green,
            onPressed: () {},
          ),
        )
      ],
    );
  }

  Widget buildImage() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(65),
          child: Image.network(
            '$API_URL${widget.userResponse.avatar}',
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Icon(
            Icons.camera_alt,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget buildPhoneText() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Số điện thoại'),
          Text(
            '${widget.userResponse.phoneNumber}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller,
      {bool obscureText = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 44,
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: TextInputType.text,
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
        ),
      ),
    );
  }
}
