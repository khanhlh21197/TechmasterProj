import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final labelController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Đăng nhập"),
        centerTitle: true,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          buildTextField('Tiêu đề', labelController),
          SizedBox(height: 10),
          buildTextField('Nội dung', contentController),
        ],
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller,
      {bool obscureText = true}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
