import 'package:http/http.dart' as http;
import 'dart:convert';

class RecentTransactionProvider {
   
  static final _url = 'http://167.172.216.181:3000';
  
  Future<Map<String, dynamic>> getCurrentOrder(id) async {

    final url = '$_url/getCurrentOrder';
    Map<String, String> headers = {"Content-Type": "application/json"};

    var data = {
      "id": id
    };

    final encodedData = json.encode(data);

    final res = await http.post(url, body: encodedData, headers: headers);

    final decodedData = json.decode(res.body);

    return decodedData;
  }
}