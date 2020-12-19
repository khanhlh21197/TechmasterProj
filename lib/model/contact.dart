import 'dart:convert';

List<Contact> contactFromJson(String str) => List<Contact>.from(json.decode(str).map((x) => Contact.fromJson(x)));

String contactToJson(List<Contact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contact {
  Contact({
    this.id,
    this.name,
    this.avatar,
  });

  int id;
  String name;
  String avatar;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
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