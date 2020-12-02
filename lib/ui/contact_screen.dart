import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController contentController = TextEditingController();
  final contentFocusNode = FocusNode();

  @override
  void dispose() {
    contentController.dispose();
    contentFocusNode.dispose();
    super.dispose();
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
        title: Text("Liên hệ"),
        centerTitle: true,
      ),
      body: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          child: SingleChildScrollView(child: buildBody()),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 15),
          buildText('Địa chỉ: ', 'VietNam'),
          buildText('Hotline: ', '0963003197'),
          buildText('Email: ', 'lek21197@gmail.com'),
          SizedBox(height: 20),
          horizontalLine(),
          buildContact(),
          horizontalLine(),
          SizedBox(
            height: 20,
          ),
          buildContent(),
          buildButton(),
        ],
      ),
    );
  }

  Widget buildButton() {
    return Container(
      alignment: AlignmentDirectional.bottomEnd,
      margin: const EdgeInsets.only(right: 16, top: 8),
      child: ButtonTheme(
        minWidth: 130,
        height: 40,
        child: RaisedButton(
          onPressed: () {},
          child: Text(
            'Gửi',
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.green,
        ),
      ),
    );
  }

  Widget buildText(String label, String data) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(data),
        ],
      ),
    );
  }

  Widget buildContact() {
    return Material(
      elevation: 2.0,
      child: Container(
        height: 70,
        child: Row(
          children: [
            Expanded(
              child: contactItem(Icons.email, 'Gửi Email'),
            ),
            verticalLine(),
            Expanded(
              child: contactItem(Icons.phone, 'Gọi điện'),
            ),
            verticalLine(),
            Expanded(
              child: contactItem(Icons.chat, 'Chat'),
            ),
          ],
        ),
      ),
    );
  }

  Widget contactItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.green,
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget buildContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nội dung phản hồi'),
          SizedBox(
            height: 5,
          ),
          contentField(),
        ],
      ),
    );
  }

  Widget contentField() {
    return Container(
      height: 60,
      child: Flexible(
        child: TextField(
          focusNode: contentFocusNode,
          maxLines: 4,
          controller: contentController,
          keyboardType: TextInputType.text,
          autocorrect: false,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            // labelStyle: ,
            // hintStyle: ,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            // suffixIcon: Icon(Icons.account_balance_outlined),
          ),
        ),
      ),
    );
  }

  Widget horizontalLine() {
    return Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey,
    );
  }

  Widget verticalLine() {
    return Container(
      width: 1,
      height: double.infinity,
      color: Colors.grey,
    );
  }
}
