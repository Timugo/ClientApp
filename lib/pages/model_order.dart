import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
    int idClient;
    String address;
    int typeService;

    OrderModel({
        this.idClient,
        this.address,
        this.typeService,
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        idClient: json["idClient"],
        address: json["address"],
        typeService: json["typeService"],
    );

    Map<String, dynamic> toJson() => {
        "idClient": idClient,
        "address": address,
        "typeService": typeService,
    };
}
