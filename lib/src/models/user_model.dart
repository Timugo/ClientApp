

import 'dart:convert';

Model registerModelFromJson(String str) => Model.fromJson(json.decode(str));

String registerModelToJson(Model data) => json.encode(data.toJson());

class Model {
    
    int phone;
    String name;
    String email;
    Model({
     
        this.phone,
        this.name='',
        this.email='',
      
    });
    factory Model.fromJson(Map<String, dynamic> json) => Model(
  
        phone: (json["phone"]),
        email: json["email"],
        name:json["pass"]
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone.toString(),
        "email": email,
      
    };
}
