class Issue {
  int id;
  String createdAt;
  String createdBy;
  String title;
  String content;
  List<dynamic> photos;
  int status;
  bool isEnable;
  AccountPublic accountPublic;

  Issue(
      {this.id,
      this.createdAt,
      this.createdBy,
      this.title,
      this.content,
      this.photos,
      this.status,
      this.isEnable,
      this.accountPublic});

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      id: json['id'],
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      title: json['title'],
      content: json['content'],
      photos: json['photos'],
      status: json['status'],
      isEnable: json['isEnable'],
    );
  }
}

class AccountPublic {
  int id;
  String name;
  String avatar;
}
