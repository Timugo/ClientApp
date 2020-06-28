import 'package:http/http.dart' as http;
import 'package:timugo/globlas.dart' as globals;
import 'dart:convert';

import 'package:timugo/src/models/publicityMethods_model.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';

final String urlBase = globals.url;

class SendDataProvider {
  final String url = urlBase + 'editInfoUser';

  Future<Map<String, dynamic>> sendData(
      int phone, String name, String email, String publi) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    var data = {
      "phone": phone,
      "name": name,
      "email": email,
      "publicityMethod": publi
    };
    final encodedData = json.encode(data);

    // make POST request
    http.Response response =
        await http.put(url, headers: headers, body: encodedData);
    final decodeData = jsonDecode(response.body);

    return decodeData;
  }
}

class GetPublicity {
  final String url = urlBase + 'getPublicityMethods';
  final prefs = PreferenciasUsuario();
  List<PublicityMethodsModel> _services = new List();

  Future<List<PublicityMethodsModel>> getpublicity() async {
    http.Response response = await http.get(url);
    final decodeData = json.decode(response.body);
    var list = decodeData['content'] as List;
    _services = list.map((i) => PublicityMethodsModel.fromJson(i)).toList();
    return _services;
  }
}
