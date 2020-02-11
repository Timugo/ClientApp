// To parse this JSON data, do
//
//     final directions = directionsFromJson(jsonString);

import 'dart:convert';

Directions directionsFromJson(String str) => Directions.fromJson(json.decode(str));

String directionsToJson(Directions data) => json.encode(data.toJson());

class Directions {
    String city;
    String address;

    Directions({
        this.city,
        this.address,
    });

    factory Directions.fromJson(Map<String, dynamic> json) => Directions(
        city: json["city"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "city": city,
        "address": address,
    };
}
