class User {
  String name;
  String phone;
  String password;
  String email;
  String address;
  String userName;

  User(
      {this.name,
      this.phone,
      this.password,
      this.email,
      this.address,
      this.userName});

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
        name: json['Name'],
        phone: json['PhoneNumber'],
        password: json['Password'],
        email: json['Email'],
        address: json['Address'],
        userName: json['UserName']);
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
