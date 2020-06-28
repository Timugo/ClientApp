//flutter dependencies
import 'package:http/http.dart' as http;
import 'package:timugo/globals.dart' as globals;
import 'dart:convert';
// Preferences
import 'package:timugo/src/preferencesUser/preferencesUser.dart';

final String urlBase = globals.url;

/* 
  Class that create a user 
*/
class RegisterUser {
  /* Request Url  */
  final String url = urlBase + 'loginUserV2';

  Future<Map<String, dynamic>> sendNumber(int phone, String city) async {
    /* Headers */
    Map<String, String> headers = {"Content-Type": "application/json"};
    /* Body */
    var data = {"phone": phone, "city": city};
    /* Response */
    final encodedData = json.encode(data);
    // making  POST request
    http.Response response =
        await http.post(url, headers: headers, body: encodedData);
    return jsonDecode(response.body);
  }
}

/*
  Class that get the user information
*/
class GetUserInformation {
  // Properties
  final String url = urlBase + 'getUser';
  final prefs = PreferenciasUsuario();

  Future<Map<String, dynamic>> getName(String phone) async {
    var _urlcode = url + '?phone=' + phone;
    // http.Response response = await http.get(_urlcode);
    //final decodeData = jsonDecode(response.body);

    //POST request (Need to be improved, servives only returns a https requests)
    http.get(_urlcode).then((response) {
      final decodeData = jsonDecode(response.body);
      if (decodeData['response'] == 2) {
        prefs.name = decodeData['content']['name'].toString();
        prefs.pts = decodeData['content']['points'].toString();
        prefs.id = decodeData['content']['id'].toString();
        prefs.email = decodeData['content']['email'].toString();
      }

      return decodeData;
    }).catchError((err) {
      //error handle
      print(err);
    });
  }
}
