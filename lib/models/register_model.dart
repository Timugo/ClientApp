import 'dart:convert';

RegisterModel welcomeFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String welcomeToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    String name;
    String phone;
    String lastName;
    String address;
    String email;
    DateTime birth;

    RegisterModel({
        this.name='',
        this.phone='',
        this.lastName='',
        this.address='',
        this.email='',
        this.birth='',
    });

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        name: json["name"],
        phone: json["phone"],
        lastName: json["lastName"],
        address: json["address"],
        email: json["email"],
        birth: DateTime.parse(json["birth"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "lastName": lastName,
        "address": address,
        "email": email,
        "birth": birth.toIso8601String(),
    };
}
