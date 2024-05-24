import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  int createdAt;
  int updatedAt;
  int id;
  String name;
  String address;
  String username;
  String phone;
  String password;
  int role;

  User({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.address,
    required this.username,
    required this.phone,
    required this.password,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        id: json["id"],
        name: json["name"],
        address: json["address"],
        username: json["username"],
        phone: json["phone"],
        password: json["password"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "id": id,
        "name": name,
        "address": address,
        "username": username,
        "phone": phone,
        "password": password,
        "role": role,
      };
}
