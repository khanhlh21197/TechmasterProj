import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:techmaster_lesson_2/loader.dart';
import 'package:techmaster_lesson_2/utilities/api_service.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final labelController = TextEditingController();
  final contentController = TextEditingController();
  PickedFile _imageFile;
  List<PickedFile> images = List();
  List<String> imageUrls = List();
  String uploadImage = '';
  dynamic _pickImageError;
  final picker = ImagePicker();

  @override
  void initState() {
    images.add(PickedFile(''));
    imageUrls.add('');
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
        title: Text("Báo cáo"),
        centerTitle: true,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTextField('Tiêu đề', labelController),
              SizedBox(height: 15),
              buildTextField('Nội dung', contentController),
              SizedBox(
                height: 20,
              ),
              buildListImage(),
              buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.green,
      ),
      child: RaisedButton(
        color: Colors.green,
        onPressed: () {
          tryPostIssue();
        },
        child: Text(
          'Lưu',
        ),
      ),
    );
  }

  void tryPostIssue() {
    String title = labelController.text;
    String content = contentController.text;
    if (title.isEmpty || content.isEmpty) {
      Dialogs.showAlertDialog(context, 'Vui lòng nhập đủ thông tin!');
      return;
    } else {
      final params = {
        'Title': title,
        'Content': content,
        'Photos': uploadImage,
      };

      apiService.request(
        path: apiService.postIssue,
        method: Method.post,
        parameters: params,
        onFailure: (message) {
          Dialogs.showAlertDialog(context, message);
        },
        onSuccess: (response) {
          print(response);
        },
      );
    }
  }

  Widget buildImageContainer() {
    return GestureDetector(
        onTap: () {
          showPickImageDialog();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(
            Icons.image,
            size: 40,
          ),
        ));
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

  void showPickImageDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            //this right here
            child: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    height: 40,
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text('Chọn ảnh từ thư viện'),
                      onPressed: () {
                        _onImageButtonPressed(ImageSource.gallery);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    height: 40,
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.blue,
                      child: Text('Chụp ảnh'),
                      onPressed: () {
                        _onImageButtonPressed(ImageSource.camera);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _onImageButtonPressed(ImageSource source) async {
    Navigator.of(context).pop();
    try {
      final pickedFile = await picker.getImage(
        source: source,
      );

      print('${pickedFile.path}');
      _imageFile = pickedFile;
      apiService.upload(
          image: File(pickedFile.path),
          onFailure: (message) {
            print('$message');
          },
          onSuccess: (imagePath) {
            print(imagePath);
            uploadImage += imagePath + '|';
            String path = apiService.baseUrl + imagePath;
            imageUrls.add(path);
            setState(() {});
          });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget buildListImage() {
    return images.isNotEmpty
        ? Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: images.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: getCrossAxisCount(images.length),
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, index) => buildImageItem(
                imageUrls[index],
                index,
              ),
            ),
          )
        : Container();
  }

  Widget buildImageItem(String url, int index) {
    return index == 0
        ? buildImageContainer()
        : Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
          );
  }

  int getCrossAxisCount(int itemCount) {
    if (itemCount == 1) {
      return 1;
    }
    if (itemCount == 2) {
      return 2;
    }
    if (itemCount >= 3) {
      return 3;
    }
    return 0;
  }

  @override
  void dispose() {
    contentController.dispose();
    labelController.dispose();
    super.dispose();
  }
}
