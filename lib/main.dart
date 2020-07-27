//Flutter dependencies
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//User dependencies
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/providers/barber_provider.dart';
import 'package:timugo/src/providers/counter_provider.dart';
import 'package:timugo/src/providers/order.dart';
import 'package:timugo/src/providers/push_notifications_provider.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/routes/routes.dart';
import 'package:timugo/src/services/number_provider.dart';
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
        initialRoute: defaultRoute(),
        navigatorKey: navigatorKey,
        routes: getAppRoutes(),
      )
    );
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
