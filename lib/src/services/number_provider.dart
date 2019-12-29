

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:timugo/src/models/barbers_model.dart';
import 'package:timugo/src/models/services_model.dart';

import 'dart:convert';

import 'package:timugo/src/models/user_model.dart';



class NumberProvider{

  final    String url = 'http://167.172.216.181:3000/loginUser';
  

   Future <Map<String,dynamic>>  sendNumber(model) async{
     
      Map<String, String> headers = {"Content-Type": "application/json"};
      String json = registerModelToJson(model);
  // make POST request
      http.Response response = await http.post(url, headers: headers, body: json);
      final decodeData = jsonDecode(response.body);
      
  
   return decodeData;
  }
}


class CodeProvider{

  final    String url = 'http://167.172.216.181:3000/sendCode';
   Future <Map<String,dynamic>>  sendCode(String  phone) async{
      var _urlcode = url+'?phone='+phone;
  // make POST request
      http.Response response = await http.get(_urlcode);
      final decodeData = jsonDecode(response.body);
   return decodeData; 
  }
}

class VerificateProvider{

  final    String url = 'http://167.172.216.181:3000/verificationCode';
   

   Future <Map<String,dynamic>>  verificateCode(String  phone,String code) async{
       Map<String, String> headers = {"Content-Type": "application/json"};
       var data = {
      "phone": phone,
      "code": code
    };
    final encodedData = json.encode(data);

  // make POST request
      http.Response response = await http.post(url, headers: headers, body: encodedData);
      final decodeData = jsonDecode(response.body);
      
  
   return decodeData;
  }
}


class SendDataProvider{

  final    String url = 'http://167.172.216.181:3000/editInfoUser';
   

   Future <Map<String,dynamic>>  sendData( int phone,String  name,String email ) async{
       Map<String, String> headers = {"Content-Type": "application/json"};
       var data = {
         "phone":phone,
          "name": name,
          "email": email
        };
    final encodedData = json.encode(data);

  // make POST request
      http.Response response = await http.put(url, headers: headers, body: encodedData);
      final decodeData = jsonDecode(response.body);
      

   return decodeData;
  }
}


class ServicesProvider  extends ChangeNotifier{

   final    String url = 'http://167.172.216.181:3000/getServices';
   List<ServicesModel> _productos = new List();

    Future<List<ServicesModel>>  getServices() async{
    http.Response response = await http.get(url);
    final decodeData = json.decode(response.body) ;
    var list = decodeData['content'] as List;
  
   _productos =list.map((i)=>ServicesModel.fromJson(i)).toList();

    
    print(_productos);
    return _productos;
  

    

  
   }
    
}
class BarbersProvider  extends ChangeNotifier{

   final    String url = 'http://167.172.216.181:3000/getBarbersTop';
   List<BarbersModel> _productos = new List();

    Future<List<BarbersModel>>  getBarbers() async{
    http.Response response = await http.get(url);
    final decodeData = json.decode(response.body) ;
    var list = decodeData['content'] as List;
  
   _productos =list.map((i)=>BarbersModel.fromJson(i)).toList();
    print(_productos);
    return _productos;
  

    

  
   }
    
}

