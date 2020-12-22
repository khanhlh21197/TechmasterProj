// To parse this JSON data, do
//
//     final issueResponse = issueResponseFromJson(jsonString);

import 'dart:convert';

IssueResponse issueResponseFromJson(String str) => IssueResponse.fromJson(json.decode(str));

String issueResponseToJson(IssueResponse data) => json.encode(data.toJson());

class IssueResponse {
  IssueResponse({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  List<Datum> data;

  factory IssueResponse.fromJson(Map<String, dynamic> json) => IssueResponse(
    code: json["code"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.createdAt,
    this.createdBy,
    this.title,
    this.content,
    this.photos,
    this.status,
    this.isEnable,
    this.accountPublic,
  });

  int id;
  String createdAt;
  String createdBy;
  String title;
  String content;
  List<String> photos;
  int status;
  bool isEnable;
  AccountPublic accountPublic;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    createdAt: json["createdAt"],
    createdBy: json["createdBy"],
    title: json["title"],
    content: json["content"],
    photos: List<String>.from(json["photos"].map((x) => x)),
    status: json["status"],
    isEnable: json["isEnable"],
    accountPublic: AccountPublic.fromJson(json["accountPublic"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt,
    "createdBy": createdBy,
    "title": title,
    "content": content,
    "photos": List<dynamic>.from(photos.map((x) => x)),
    "status": status,
    "isEnable": isEnable,
    "accountPublic": accountPublic.toJson(),
  };
}

class AccountPublic {
  AccountPublic({
    this.id,
    this.name,
    this.avatar,
  });

  int id;
  String name;
  String avatar;

  factory AccountPublic.fromJson(Map<String, dynamic> json) => AccountPublic(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
  };
}
