import 'dart:convert';

IServerResponse iServerResponseFromJson(String str) =>
    IServerResponse.fromJson(json.decode(str));

String iServerResponseToJson(IServerResponse data) =>
    json.encode(data.toJson());

class IServerResponse {
  int response ;
  final content ;
  String message;
  IServerResponse({
    this.response,
    this.content,
    this.message
  });

  factory IServerResponse.fromJson(Map<String, dynamic> json) =>
    IServerResponse(
      response : json["response"],
      content : json["content"],
      message:  json["content"]["message"]
    );

  Map<String, dynamic> toJson() => {
    "response" : response,
    "content" : content
  };
}
