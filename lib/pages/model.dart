
import 'dart:convert';

Model registerModelFromJson(String str) => Model.fromJson(json.decode(str));

String registerModelToJson(Model data) => json.encode(data.toJson());

class Model {
    String firstName;
    int phone;
    String lastName;
    String address;
    String email;
    String password;
    DateTime birth;

    Model({
        this.firstName='',
        this.phone,
        this.lastName='',
        this.address='',
        this.email='',
        this.password,
        this.birth,
    });

    factory Model.fromJson(Map<String, dynamic> json) => Model(
        firstName: json["name"],
        phone: (json["phone"]),
        lastName: json["lastName"],
        address: json["address"],
        email: json["email"],
        birth: DateTime.parse(json["birth"]),
        password:json["pass"]
    );

    Map<String, dynamic> toJson() => {
        "name": firstName,
        "phone": phone.toString(),
        "lastName": lastName,
        "address": address,
        "email": email,
        "birth": birth.toString(),
        "pass" :password,
    };
}
