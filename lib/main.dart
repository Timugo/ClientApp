//Flutter dependencies
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timugo/src/interfaces/server_response.dart';
import 'package:timugo/src/pages/Login/application/login_page.dart';
import 'package:timugo/src/pages/checkin/application/checkin_page.dart';
import 'package:timugo/src/pages/checkout/application/checkout_page.dart';
import 'package:timugo/src/pages/orderinprocess/orderinprocces_page.dart';
import 'package:timugo/src/pages/register/application/registerData_page.dart';
import 'package:timugo/src/pages/register/application/widgets/publicitymethods_widget.dart';
//User dependencies
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/providers/barber_provider.dart';
import 'package:timugo/src/providers/counter_provider.dart';
import 'package:timugo/src/providers/order.dart';
import 'package:timugo/src/providers/push_notifications_provider.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
//pages
import 'package:timugo/src/pages/homeservices/application/services_page.dart';
import 'package:timugo/src/pages/directions/application/pages/saveaddress_page.dart';
import 'package:timugo/src/widgets/screenloader_widget.dart';
//enviroment
import 'package:timugo/globals.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  @override
  void initState() {
    //Config of push notification provider
    super.initState();
    final pushProvider = PushNotificationProvider();
    
    //initialize the push notification provider
    pushProvider.initNotifications();
    // if the push message is detected
    pushProvider.messages.listen((data) {
      if (data == 'cancel') {
        navigatorKey.currentState.pushNamed('services');
      }
      if (data == 'taken') {
        navigatorKey.currentState.pushNamed('orderProccess');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => UserInfo()),
        ChangeNotifierProvider(builder: (context) => ServicesProvider()),
        ChangeNotifierProvider(builder: (context) => BarberAsigned()),
        ChangeNotifierProvider(builder: (context) => Counter()),
        ChangeNotifierProvider(builder: (context) => Orderinfo()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: _checkDebugVersion(),
        initialRoute: _defaultPage(),
        navigatorKey: navigatorKey,
        routes: {
          'login': (context) => LoginPage(),
          'registerData': (context) => RegisterUserData(),
          'services': (context) => Services(),
          'checkin': (context) => Checkin(),
          'checkout': (context) => Checkout(),
          'orderProccess': (context) => OrderProcces(),
          'publicity': (context) => PublicityMethods(),
          'FormDirections': (context) => FormDirections(address: null),
          'screnloader': (context) => ScreenLoaderClass()
        },
      )
    );
  }

  /*
    This function return the route to navigate
    after phone starts 
  */
  _defaultPage<String>() {
    
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

  /*
    This function checks if the current enviroment is development or production
    development : return true
    production : return false
  */
  bool _checkDebugVersion(){
    var urlBase = globals.url;
    //production
    if(urlBase == "https://api.timugo.com/"){
      return false;
    }else{
      // development
      return true;
    }
  }
}
