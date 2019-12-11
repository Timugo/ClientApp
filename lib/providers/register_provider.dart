import 'dart:convert';
import 'package:http/http.dart' as http ;
import 'package:timugo_client_app/pages/ServicesModel.dart';
import 'package:timugo_client_app/pages/model.dart';
import 'package:timugo_client_app/pages/model_feed.dart';
import 'package:timugo_client_app/pages/model_order.dart';

class RegisterProvider{

  final    String url = 'http://167.99.99.86/addUser';
  

   Future <Map<String,dynamic>>  createUser(model) async{
     
      Map<String, String> headers = {"Content-Type": "application/json"};
      String json = registerModelToJson(model);
  // make POST request
      http.Response response = await http.post(url, headers: headers, body: json);
      final decodeData = jsonDecode(response.body);
      
  
   return decodeData;
   }
   
   

}
class OrderProvider{
   final    String url = 'http://167.172.216.181:3000/createOrder';
  

   Future <Map<String,dynamic>>  createOrder(order) async{
     
      Map<String, String> headers = {"Content-Type": "application/json"};
      String json = orderModelToJson(order);
  // make POST request
      http.Response response = await http.post(url, headers: headers, body: json);
      final decodeData = jsonDecode(response.body);

   return decodeData;
   }




  
}
class ServicesProvider{
   final    String url = 'http://167.172.216.181:3000/getServices';
  

    Future<List<ServicesModel>>  getServices() async{
     
      // Map<String, String> headers = {"Content-Type": "application/json"};
      // String json = orderModelToJson(order);
  // make POST request
    http.Response response = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(response.body);
    final List<ServicesModel> productos = new List();


    if ( decodeData == null ) return [];

    decodeData.forEach( ( id, prod ){

      final prodTemp = ServicesModel.fromJson(prod);

    });
    return productos;
  

    

  
   }




  
}

class FeedProvider{
 final    String url = 'http://167.172.216.181:3000/finishOrder';
  

   Future <Map<String,dynamic>>  finishOrder(feed) async{
     
      Map<String, String> headers = {"Content-Type": "application/json"};
      String json = feedModelToJson(feed);
  // make POST request
      http.Response response = await http.post(url, headers: headers, body: json);
      final decodeData = jsonDecode(response.body);

   return decodeData;

    

  
   }




  
}