class UserResponse {
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

  UserResponse(
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
      this.token);

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      json['id'],
      json['createdAt'],
      json['createdBy'],
      json['modifiedAt'],
      json['modifiedBy'],
      json['name'],
      json['dateOfBirth'],
      json['address'],
      json['gender'],
      json['phoneNumber'],
      json['email'],
      json['avatar'],
      json['token'],
    );
  }
}
