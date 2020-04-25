// To parse this JSON data, do
//
//     final cardModel = cardModelFromJson(jsonString);

import 'dart:convert';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
    String last4Numbers;
    String brand;
    String fullName;
    bool favorite;

    CardModel({
        this.last4Numbers,
        this.brand,
        this.fullName,
        this.favorite,
    });

    factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        last4Numbers: json["last4Numbers"],
        brand: json["brand"],
        fullName: json["fullName"],
        favorite: json["favorite"],
    );

    Map<String, dynamic> toJson() => {
        "last4Numbers": last4Numbers,
        "brand": brand,
        "fullName": fullName,
        "favorite": favorite,
    };
}
