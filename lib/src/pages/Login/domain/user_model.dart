// Flutter dependencies
import 'package:flutter/cupertino.dart';
import 'dart:convert';

UserModel registerUserModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String registerUserModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel with ChangeNotifier {
  int phone;
  String name;
  String email;
  UserModel({
    this.phone,
    this.name = '',
    this.email = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    phone: json["phone"],
    email: json["email"],
    name: json["name"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone.toString(),
    "email": email,
  };
}
