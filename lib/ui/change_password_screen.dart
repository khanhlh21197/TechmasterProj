import 'package:flutter/material.dart';
import 'package:techmaster_lesson_2/loader.dart';
import 'package:techmaster_lesson_2/utilities/api_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final newPassAgainController = TextEditingController();

  @override
  void dispose() {
    oldPassController.dispose();
    newPassController.dispose();
    newPassAgainController.dispose();
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
        title: Text("Đổi mật khẩu"),
        centerTitle: true,
      ),
      body: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: buildBody(),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        SizedBox(height: 20),
        buildTextField('Mật khẩu cũ', oldPassController),
        SizedBox(height: 20),
        buildTextField('Mật khẩu mới', newPassController),
        SizedBox(height: 20),
        buildTextField('Gõ lại mật khẩu mới', newPassAgainController),
        SizedBox(
          height: 15,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: RaisedButton(
            child: Text('Lưu'),
            color: Colors.green,
            onPressed: () {
              tryChangePassword();
            },
          ),
        )
      ],
    );
  }

  void tryChangePassword() {
    final newPass = newPassController.text;
    final oldPass = oldPassController.text;
    final newPassAgain = newPassAgainController.text;
    if (newPass.isEmpty || oldPass.isEmpty || newPassAgain.isEmpty) {
      Dialogs.showAlertDialog(context, 'Vui lòng nhập đủ thông tin');
    } else {
      final params = {
        'OldPassword': oldPass,
        'NewPassword': newPass,
      };

      apiService.request(
          path: apiService.changePassword,
          method: Method.post,
          parameters: params,
          onSuccess: (response) {
            Dialogs.showAlertDialog(context, 'Đổi mật khẩu thành công!');
          },
          onFailure: (message) {
            Dialogs.showAlertDialog(context, message);
          });
    }
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
