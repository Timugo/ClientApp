// To parse this JSON data, do
//
//     final servicesModel = servicesModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';


ServicesModel servicesModelFromJson(String str) => ServicesModel.fromJson(json.decode(str));

String servicesModelToJson(ServicesModel data) => json.encode(data.toJson());

class ServicesModel with ChangeNotifier {
    int id;
    String name;
    String price;
    String description;
    String urlImg;

    ServicesModel({
        this.id,
        this.name,
        this.price,
        this.description,
        this.urlImg,
    });

    factory ServicesModel.fromJson(Map<String, dynamic> json) => ServicesModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        urlImg: json["urlImg"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "urlImg": urlImg,
    };
}
