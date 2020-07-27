//FLutter dependencies
import 'package:flutter/material.dart';
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