import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
    int id;
    String nameService;
    String typeService;
    String price;
    int quantity;

    OrderModel({
        this.nameService,
        this.typeService ,
        this.id,
        this.price,
        this.quantity
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        nameService: json["nameService"],
        typeService: json["typeService"],
        price:json["price"],
        quantity: json["quantity"]
    );

    Map<String, dynamic> toJson() => {
        "nameService": nameService,
        "typeService": typeService,
        "id": id,
        "price":price,
        "quantity":quantity
    };
}
