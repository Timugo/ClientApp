import 'dart:convert';

// Converter
IServerResponse iServerResponseFromJson(String str) =>
    IServerResponse.fromJson(json.decode(str));
// Converter
String iServerResponseToJson(IServerResponse data) =>
    json.encode(data.toJson());

// main class
class IServerResponse {
  int response ;
  Object content;
  //Constructor
  IServerResponse({
    this.response,
    this.content
  });

  factory IServerResponse.fromJson(Map<String, dynamic> json) =>
    IServerResponse(
      response : json["response"],
      content : json["content"]
    );

  Map<String, dynamic> toJson() => {
    "response" : response,
    "content" : content
  };
}
