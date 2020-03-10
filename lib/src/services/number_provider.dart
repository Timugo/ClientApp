
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:timugo/src/models/aditional_model.dart';
import 'package:timugo/src/models/barbers_model.dart';
import 'package:timugo/src/models/directions_model.dart';
import 'package:timugo/src/models/publicity_model.dart';
import 'package:timugo/src/models/services_model.dart';
import 'package:timugo/src/models/temporalOrder_model.dart';

import 'dart:convert';

import 'package:timugo/src/models/user_model.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/globlas.dart' as globals;

final String  urlBase = globals.url;
class NumberProvider{

  final    String url = 'urlBaseloginUser';
  

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

  final    String url = 'urlBasesendCode';
   Future <Map<String,dynamic>>  sendCode(String  phone) async{
      var _urlcode = url+'?phone='+phone;
  // make POST request
      http.Response response = await http.get(_urlcode);
      final decodeData = jsonDecode(response.body);
   return decodeData; 
  }
}

class VerificateProvider{

  final    String url = 'urlBaseverificationCode';
   

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

  final    String url = 'urlBaseeditInfoUser';
   

   Future <Map<String,dynamic>>  sendData( int phone,String  name,String email,String publi ) async{
       Map<String, String> headers = {"Content-Type": "application/json"};
       var data = {
         "phone":phone,
          "name": name,
          "email": email,
          "publicityMethod":publi
        };
    final encodedData = json.encode(data);

  // make POST request
      http.Response response = await http.put(url, headers: headers, body: encodedData);
      final decodeData = jsonDecode(response.body);
      

   return decodeData;
  }
}


class ServicesProvider  extends ChangeNotifier{

   final    String url = 'urlBasegetServices';
   List<ServicesModel> _productos = new List();

    Future<List<ServicesModel>>  getServices() async{
    http.Response response = await http.get(url);
    final decodeData = json.decode(response.body) ;
    var list = decodeData['content'] as List;
  
   _productos =list.map((i)=>ServicesModel.fromJson(i)).toList();
    return _productos;
  

    

  
   }
    
}
class BarbersProvider  extends ChangeNotifier{

   final    String url = 'urlBasegetBarbersTop';
   List<BarbersModel> _productos = new List();
    
    Future<List<BarbersModel>>  getBarbers() async{
    http.Response response = await http.get(url);
    final decodeData = json.decode(response.body);
    var list = decodeData['content'] as List;
  
   _productos =list.map((i)=>BarbersModel.fromJson(i)).toList();
   
    return _productos;
   }
    
}

class AditionalProvider  extends ChangeNotifier{

   final    String url = 'urlBasegetAditionalServices';
   List<AditionalModel> _productos = new List();

    Future<List<AditionalModel>>  getAditional(String id) async{
    var _urlcode = url+'?service='+id;
    http.Response response = await http.get(_urlcode);
    final decodeData = json.decode(response.body) ;
    var list = decodeData['content'] as List;
  
   _productos =list.map((i)=>AditionalModel.fromJson(i)).toList();
    
    return _productos;
  

    

  
   }
    
}
class TokenProvider{

  final    String url = 'urlBaseaddPhoneTokenUser';
   

   Future <Map<String,dynamic>> sendToken(String  phone,String token) async{
       Map<String, String> headers = {"Content-Type": "application/json"};
       var data = {
      "phoneUser": phone,
      "phoneToken": token
    };
    final encodedData = json.encode(data);
    
  // make POST request
      http.Response response = await http.put(url, headers: headers, body: encodedData);
      final decodeData = jsonDecode(response.body);
      
  
   return decodeData;
  }
}

class DirectionProvider{

  final    String url = 'urlBaseaddAddressUser';
   

   Future <Map<String,dynamic>> sendDirection(int phone,String  city,String address) async{
       Map<String, String> headers = {"Content-Type": "application/json"};
       var data = {
        "phone":phone,
        "city": city,
        "address": address
      };
    final encodedData = json.encode(data);
  // make POST request
      http.Response response = await http.put(url, headers: headers, body: encodedData);
      final decodeData = jsonDecode(response.body);
      
  
   return decodeData;
  }
}

class UserProvider{
  final    String url = 'urlBasegetUser';
  final prefs =  PreferenciasUsuario();
  
    Future<Map<String,dynamic>>  getName(String  phone) async{
        var _urlcode = url+'?phone='+phone;
    // make POST request
        http.Response response = await http.get(_urlcode);
        final decodeData = jsonDecode(response.body);
       // final userInfo   = Provider.of<UserInfo>();
        if (decodeData['response'] == 2){
        prefs.name=decodeData['content']['name'].toString();
        prefs.pts=decodeData['content']['points'].toString();
        prefs.id = decodeData['content']['id'].toString();
        prefs.email = decodeData['content']['email'].toString();
      //  userInfo.pts=decodeData['content']['points'];
        }
    return decodeData; 
    }
  }

 
class CreateOrderProvider{

  final    String url = 'urlBasecreateOrder';
   final prefs =  PreferenciasUsuario();
   

   Future <Map<String,dynamic>>  createOrder(int  id,String address,String city,List services) async{
       Map<String, String> headers = {"Content-Type": "application/json"};
       var data = {
          "idClient": id,
          "address": address,
          "city":city,
          "services":json.encode(services)

        };
    final encodedData = json.encode(data);

  // make POST request
      http.Response response = await http.post(url, headers: headers, body: encodedData);
      final decodeData = jsonDecode(response.body);
      if (decodeData['response']== 2){

           prefs.order=(decodeData['content']['orderDB']['id']).toString();
      }
     
      
      
  
   return decodeData;
  }
}

class TemporalOrderProvider  extends ChangeNotifier{

   final    String url = 'urlBasegetInfoTemporalOrder';
    final prefs =  PreferenciasUsuario();
    

   List<TemporalServices> _services = new List();

    Future<List<TemporalServices>>  getTemporalProvider() async{
    var _urlcode = url+'?idOrder='+prefs.order;
    http.Response response = await http.get(_urlcode);
    final decodeData = json.decode(response.body) ;
    if(decodeData['response']== 2){
          var list = decodeData['content']['order']['services'] as List;

            _services =list.map((i)=>TemporalServices.fromJson(i)).toList();
    }
    

    return _services;

   }
  
 Future <Map<String,dynamic>>  getBarberAsigned() async{
    var _urlcode = url+'?idOrder='+prefs.order;
    http.Response response = await http.get(_urlcode);
    final decodeData = json.decode(response.body) ;

    if (decodeData['response'] == 1){
              prefs.order = '0';
               
     }

   
    

    return decodeData;

   }

    
}
class FinishOrderProvider{

  final    String url = 'urlBasefinishOrder';
   final prefs =  PreferenciasUsuario();
   

   Future <Map<String,dynamic>>  finishOrder() async{
       Map<String, String> headers = {"Content-Type": "application/json"};
       var data = {
          "idOrder": int.parse(prefs.order),
          "comment": '',
          "status":"Cancelled",
         

        };
    final encodedData = json.encode(data);

  // make POST request
      http.Response response = await http.post(url, headers: headers, body: encodedData);
      final decodeData = jsonDecode(response.body);

   return decodeData;
  }
}

class EditOrderProvider{

  final    String url = 'urlBaseeditOrder';
  final prefs =  PreferenciasUsuario();

   Future <Map<String,dynamic>> editOrderProvider(List services) async{
       Map<String, String> headers = {"Content-Type": "application/json"};
       var data = {
      "idOrder": int.parse(prefs.order),
      "services":json.encode(services)
    };
    final encodedData = json.encode(data);

  // make POST request
      http.Response response = await http.put(url, headers: headers, body: encodedData);
      final decodeData = jsonDecode(response.body);
      
  
   return decodeData;
  }
}

class GetAddresses{

  final    String url = 'urlBasegetAddressesUser';
  final prefs =  PreferenciasUsuario();
  List<Directions> _services = new List();

  Future <List<Directions>>  getAddresses() async{
    var _urlcode = url+'?phone='+prefs.token;
    http.Response response = await http.get(_urlcode);
    final decodeData = json.decode(response.body) ;

     var list = decodeData['content'] as List;
  
   _services =list.map((i)=>Directions.fromJson(i)).toList();
    

    return _services;

   
  }
}


class DeleteAddress{

  final    String url = 'urlBasedeleteAddressUser';
     final prefs =  PreferenciasUsuario();


   Future <Map<String,dynamic>> deleteaddress(String address) async{
       Map<String, String> headers = {"Content-Type": "application/json"};
       var data = {
      "phone":prefs.token ,
      "address": address
    };
    final encodedData = json.encode(data);

  // make POST request
      http.Response response = await http.put(url, headers: headers, body: encodedData);
      final decodeData = jsonDecode(response.body);
      
  
   return decodeData;
  }
}

class CheckUserOrder{

  final    String url = 'urlBasecheckUserOrder';
  final prefs =  PreferenciasUsuario();
  var res = 'false';
  Future <Map<String,dynamic>>  checkUserOrder() async{
    var _urlcode = url+'?idUser='+prefs.id;
    http.Response response = await http.get(_urlcode);
    final decodeData = json.decode(response.body) ;
   
  if (decodeData['response'] == 2){
    prefs.order=decodeData['content']['id'].toString();

  }

    
    
    return decodeData;
    

   
  }
}
class SendFeedBack{

  final    String url = 'urlBasegiveFeedback';
   final prefs =  PreferenciasUsuario();
   

   Future <Map<String,dynamic>>  sendFeedBack(String comment) async{
       Map<String, String> headers = {"Content-Type": "application/json"};
       var data = {
          "phoneUser": prefs.token,
          "comment": comment,

        };
    final encodedData = json.encode(data);

  // make POST request
      http.Response response = await http.post(url, headers: headers, body: encodedData);
      final decodeData = jsonDecode(response.body);
      
      
  
   return decodeData;
  }
}

class GetPublicity{

  final    String url = 'urlBasegetPublicityMethods';
  final prefs =  PreferenciasUsuario();
  List<PublicityMethods> _services = new List();

  Future <List<PublicityMethods>>  getpublicity() async{

    http.Response response = await http.get(url);
    final decodeData = json.decode(response.body) ;

     var list = decodeData['content'] as List;
     
     
  
   _services =list.map((i)=>PublicityMethods.fromJson(i)).toList();
    
    
    return _services;

   
  }
}