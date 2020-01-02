
import 'dart:convert';

AditionalModel aditionalModelFromJson(String str) => AditionalModel.fromJson(json.decode(str));

String aditionalModelToJson(AditionalModel data) => json.encode(data.toJson());

class AditionalModel {
    String name;
    String price;

    AditionalModel({
        this.name,
        this.price ,
    });

    factory AditionalModel.fromJson(Map<String, dynamic> json) => AditionalModel(
        name: json["name"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
    };
}
