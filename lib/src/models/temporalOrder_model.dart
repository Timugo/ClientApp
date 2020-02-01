// To parse this JSON data, do
//
//     final temporalServices = temporalServicesFromJson(jsonString);

import 'dart:convert';

TemporalServices temporalServicesFromJson(String str) => TemporalServices.fromJson(json.decode(str));

String temporalServicesToJson(TemporalServices data) => json.encode(data.toJson());

class TemporalServices {
    String nameService;
    int id;
    int price;
    int quantity;

    TemporalServices({
        this.nameService,
        this.price,
        this.quantity,
        this.id
    });

    factory TemporalServices.fromJson(Map<String, dynamic> json) => TemporalServices(
        nameService: json["nameService"],
        price: json["price"],
        quantity: json["quantity"],
        id:json['id']
    );

    Map<String, dynamic> toJson() => {
        "nameService": nameService,
        "price": price,
        "quantity": quantity,
        'id': id
    };
}
