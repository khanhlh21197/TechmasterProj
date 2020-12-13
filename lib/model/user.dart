class User {
  String name;
  String phone;
  String password;
  String email;
  String address;
  String userName;
  String token;

  User(
      {this.name,
      this.phone,
      this.password,
      this.email,
      this.address,
      this.userName,
      this.token});

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
        name: json['Name'],
        phone: json['PhoneNumber'],
        password: json['Password'],
        email: json['Email'],
        address: json['Address'],
        userName: json['UserName'],
        token: json['token']);
  }

  Map<dynamic, dynamic> toJson() => {
        'Name': name,
        'PhoneNumber': phone,
        'Email': email,
        'Address': address,
        'Password': password,
        'UserName': userName,
      };
}
