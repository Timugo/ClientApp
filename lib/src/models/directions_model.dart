// To parse this JSON data, do
//
//     final directions = directionsFromJson(jsonString);

import 'dart:convert';

Directions directionsFromJson(String str) => Directions.fromJson(json.decode(str));

String directionsToJson(Directions data) => json.encode(data.toJson());

class Directions {
    String city;
    String address;
    bool favorite;

    Directions({
        this.city,
        this.address,
        this.favorite
    });

    factory Directions.fromJson(Map<String, dynamic> json) => Directions(
        city: json["city"],
        address: json["address"],
        favorite: json["favorite"]
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "address": address,
        "favorite":favorite
    };
}
