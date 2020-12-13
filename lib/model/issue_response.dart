import 'package:techmaster_lesson_2/model/issue.dart';

class IssueResponse {
  int code;
  String message;
  List<dynamic> data;

  IssueResponse({this.code, this.message, this.data});

  factory IssueResponse.fromJson(Map<String, dynamic> json) {
    return IssueResponse(
      code: json['code'],
      message: json['message'],
      data: json['data'],
    );
  }
}
