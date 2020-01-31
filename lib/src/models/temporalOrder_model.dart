// To parse this JSON data, do
//
//     final temporalServices = temporalServicesFromJson(jsonString);

import 'dart:convert';

TemporalServices temporalServicesFromJson(String str) => TemporalServices.fromJson(json.decode(str));

String temporalServicesToJson(TemporalServices data) => json.encode(data.toJson());

class TemporalServices {
    String nameService;
    int price;
    int quantity;

    TemporalServices({
        this.nameService,
        this.price,
        this.quantity,
    });

    factory TemporalServices.fromJson(Map<String, dynamic> json) => TemporalServices(
        nameService: json["nameService"],
        price: json["price"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "nameService": nameService,
        "price": price,
        "quantity": quantity,
    };
}
