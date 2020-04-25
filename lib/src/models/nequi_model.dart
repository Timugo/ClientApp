// To parse this JSON data, do
//
//     final nequiModel = nequiModelFromJson(jsonString);

import 'dart:convert';

NequiModel nequiModelFromJson(String str) => NequiModel.fromJson(json.decode(str));

String nequiModelToJson(NequiModel data) => json.encode(data.toJson());

class NequiModel {
    bool favorite;
    String type;
    String phone;
    String date;
    String token;

    NequiModel({
        this.favorite,
        this.type,
        this.phone,
        this.date,
        this.token,
    });

    factory NequiModel.fromJson(Map<String, dynamic> json) => NequiModel(
        favorite: json["favorite"],
        type: json["type"],
        phone: json["phone"],
        date: json["date"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "favorite": favorite,
        "type": type,
        "phone": phone,
        "date": date,
        "token": token,
    };
}
