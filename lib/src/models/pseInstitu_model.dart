import 'dart:convert';

InstituPse instituPseFromJson(String str) => InstituPse.fromJson(json.decode(str));

String instituPseToJson(InstituPse data) => json.encode(data.toJson());

class InstituPse {
    String name;
    String code;

    InstituPse({
        this.name,
        this .code
    });

    factory InstituPse.fromJson(Map<String, dynamic> json) => InstituPse(
        name: json["name"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code":code,
    };
}
