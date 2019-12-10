import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginProvider {
   
  static final _url = 'http://167.99.99.86';
  

  Future<Map<String, dynamic>> login(email, password) async {

    final url = '$_url/login';
    Map<String, String> headers = {"Content-Type": "application/json"};

    var data = {
      "email": email,
      "password": password
    };
    final encodedData = json.encode(data);

    final res = await http.post(url, body: encodedData, headers: headers);

    final decodedData = json.decode(res.body);

    return decodedData;
  }
   
  
}