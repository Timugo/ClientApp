import 'dart:convert';

import 'package:http/http.dart' as http ;
import 'package:timugo_client_app/pages/model.dart';

class RegisterProvider{

  final    String url = 'http://157.245.121.236:3000/addUser';
  

   Future <bool>  createUser(model) async{
     try {
      Map<String, String> headers = {"Content-type": "application/json"};
      String json = registerModelToJson(model);
  // make POST request
      http.Response response = await http.post(url, headers: headers, body: json);
      print(response);
      }
      catch (e){
    print(e);
    }
   return true;


   
}
}

