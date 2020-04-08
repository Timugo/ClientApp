import 'dart:convert';

Cities citiesFromJson(String str) => Cities.fromJson(json.decode(str));

String citiesToJson(Cities data) => json.encode(data.toJson());

class Cities {
    String name;

    Cities({
        this.name,
    });

    factory Cities.fromJson(Map<String, dynamic> json) => Cities(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
