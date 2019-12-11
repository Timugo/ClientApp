
import 'dart:convert';

FeedModel feedModelFromJson(String str) => FeedModel.fromJson(json.decode(str));

String feedModelToJson(FeedModel data) => json.encode(data.toJson());

class FeedModel {
    int idOrder;
    int stars;
    String comment;

    FeedModel({
        this.idOrder,
        this.stars,
        this.comment,
    });

    factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        idOrder: json["idOrder"],
        stars: json["stars"],
        comment: json["comment"],
    );

    Map<String, dynamic> toJson() => {
        "idOrder": idOrder,
        "stars": stars,
        "comment": comment,
    };
}
