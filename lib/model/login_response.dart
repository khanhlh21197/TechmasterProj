import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.code,
    this.message,
    this.data,
  });

  int code;
  String message;
  Data data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.createdAt,
    this.createdBy,
    this.modifiedAt,
    this.modifiedBy,
    this.name,
    this.dateOfBirth,
    this.address,
    this.gender,
    this.phoneNumber,
    this.email,
    this.avatar,
    this.token,
  });

  int id;
  String createdAt;
  String createdBy;
  String modifiedAt;
  String modifiedBy;
  String name;
  String dateOfBirth;
  String address;
  bool gender;
  String phoneNumber;
  String email;
  String avatar;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    createdAt: json["createdAt"],
    createdBy: json["createdBy"],
    modifiedAt: json["modifiedAt"],
    modifiedBy: json["modifiedBy"],
    name: json["name"],
    dateOfBirth: json["dateOfBirth"],
    address: json["address"],
    gender: json["gender"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    avatar: json["avatar"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "createdAt": createdAt,
    "createdBy": createdBy,
    "modifiedAt": modifiedAt,
    "modifiedBy": modifiedBy,
    "name": name,
    "dateOfBirth": dateOfBirth,
    "address": address,
    "gender": gender,
    "phoneNumber": phoneNumber,
    "email": email,
    "avatar": avatar,
    "token": token,
  };
}