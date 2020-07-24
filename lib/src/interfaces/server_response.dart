import 'dart:convert';

// Converter
IServerResponse iServerResponseFromJson(String str) =>
    IServerResponse.fromJson(json.decode(str));
// Converter
String iServerResponseToJson(IServerResponse data) =>
    json.encode(data.toJson());

class IServerResponse {
  // props
  int response ;
  Object content;
  String message;
  //Constructor
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
