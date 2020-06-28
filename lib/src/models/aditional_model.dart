import 'dart:convert';

AditionalModel aditionalModelFromJson(String str) =>
    AditionalModel.fromJson(json.decode(str));

String aditionalModelToJson(AditionalModel data) => json.encode(data.toJson());

class AditionalModel {
  int id;
  String name;
  String price;

  AditionalModel({this.name, this.price, this.id});

  factory AditionalModel.fromJson(Map<String, dynamic> json) => AditionalModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {"name": name, "price": price, "id": id};
}
