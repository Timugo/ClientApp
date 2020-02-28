import 'dart:convert';

PublicityMethods publicityMethodsFromJson(String str) => PublicityMethods.fromJson(json.decode(str));

String publicityMethodsToJson(PublicityMethods data) => json.encode(data.toJson());

class PublicityMethods {
    String name;

    PublicityMethods({
        this.name,
    });

    factory PublicityMethods.fromJson(Map<String, dynamic> json) => PublicityMethods(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
