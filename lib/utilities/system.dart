import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

//void copyToClipboard(String text,
//		{String successMessage, BuildContext context}) {
//	if (isNotEmpty(text)) {
//		Clipboard.setData(new ClipboardData(text: text));
//		if (context != null) {
//			Scaffold.of(context)?.showSnackBar(new SnackBar(
//					duration: Duration(seconds: 1),
//					content: new Text(successMessage ?? "Sao chép thành công.")));
//		}
//	}
//}

void hideKeyboard() {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

void hideKeyboardAndUnFocus(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}