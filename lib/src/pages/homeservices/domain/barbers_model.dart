// To parse this JSON data, do
//
//     final barbersModel = barbersModelFromJson(jsonString);

import 'dart:convert';

BarbersModel barbersModelFromJson(String str) => BarbersModel.fromJson(json.decode(str));

String barbersModelToJson(BarbersModel data) => json.encode(data.toJson());

class BarbersModel {
    int id;
    double stairs;
    String urlImg;
    String name;
    String email;
    DateTime birth;
    int phone;
    String bio;

    BarbersModel({
        this.id,
        this.stairs,
        this.urlImg,
        this.name,
        this.email,
        this.birth,
        this.phone,
        this.bio,
    });

    factory BarbersModel.fromJson(Map<String, dynamic> json) => BarbersModel(
        id: json["id"],
        stairs:json["stairs"]*1.0,
        urlImg: json["urlImg"],
        name: json["name"],
        email: json["email"],
        birth: DateTime.parse(json["birth"]),
        phone: json["phone"],
        bio: json["bio"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "stairs": stairs,
        "urlImg": urlImg,
        "name": name,
        "email": email,
        "birth": birth.toIso8601String(),
        "phone": phone,
        "bio": bio,
    };
}
