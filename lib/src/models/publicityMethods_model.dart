import 'dart:convert';

PublicityMethodsModel publicityMethodsFromJson(String str) =>
    PublicityMethodsModel.fromJson(json.decode(str));

String publicityMethodsToJson(PublicityMethodsModel data) =>
    json.encode(data.toJson());

class PublicityMethodsModel {
  String name;

  PublicityMethodsModel({
    this.name,
  });

  factory PublicityMethodsModel.fromJson(Map<String, dynamic> json) =>
      PublicityMethodsModel(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
