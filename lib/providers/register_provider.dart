import 'dart:convert';
import 'package:http/http.dart' as http ;
import 'package:timugo_client_app/pages/model.dart';

class RegisterProvider{

  final    String url = 'http://167.99.99.86:3000/addUser';
  

   Future <Map<String,dynamic>>  createUser(model) async{
     
      Map<String, String> headers = {"Content-Type": "application/json"};
      String json = registerModelToJson(model);
  // make POST request
      http.Response response = await http.post(url, headers: headers, body: json);
      final decodeData = jsonDecode(response.body);
      
  
   return decodeData;


   
}
}

