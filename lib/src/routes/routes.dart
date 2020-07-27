//FLutter dependencies
import 'dart:convert';
import 'package:flutter/material.dart';
// Providers
import 'package:timugo/src/services/number_provider.dart';
// Interfaces
import 'package:timugo/src/interfaces/server_response.dart';
// Pages
import 'package:timugo/src/pages/Login/application/login_page.dart';
import 'package:timugo/src/pages/checkin/application/checkin_page.dart';
import 'package:timugo/src/pages/checkout/application/checkout_page.dart';
import 'package:timugo/src/pages/directions/application/pages/saveaddress_page.dart';
import 'package:timugo/src/pages/homeservices/application/services_page.dart';
import 'package:timugo/src/pages/orderinprocess/orderinprocces_page.dart';
import 'package:timugo/src/pages/register/application/registerData_page.dart';
import 'package:timugo/src/pages/register/application/widgets/publicitymethods_widget.dart';
import 'package:timugo/src/widgets/screenloader_widget.dart';


Map<String,WidgetBuilder> getAppRoutes(){
  return <String,WidgetBuilder> {
    'login': (context) => LoginPage(),
    'registerData': (context) => RegisterUserData(),
    'services': (context) => Services(),
    'checkin': (context) => Checkin(),
    'checkout': (context) => Checkout(),
    'orderProccess': (context) => OrderProcces(),
    'publicity': (context) => PublicityMethods(),
    'FormDirections': (context) => FormDirections(address: null),
    'screnloader': (context) => ScreenLoaderClass()
  };
}

/*
    This function return the route to navigate
    after phone starts 
  */
String defaultRoute() {
  final userService = CheckUserOrder();
  // Routes Switch
  if (prefs.token != '') {
    var route = 'services';
    //Check in the server if has an order in progress
    userService.checkUserOrder()
      .then((resp) {
        final response = iServerResponseFromJson(resp.body);
        if (response.response == 1) {
          route = 'services';
          prefs.order = "0";
        } else if (response.response ==2 ) {
          route = 'orderProccess';
          var decodeData  = json.decode(resp.body);
          prefs.order = decodeData['content']['id'].toString();
        }
      });
    return route;
  } else {
    return 'login';
  }
}