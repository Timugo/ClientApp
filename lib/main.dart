//Flutter dependencies
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  @override
  void initState() {
    //Config of push notification provider
    super.initState();
    final pushProvider = PushNotificationProvider();
    //temporal order to check if user has a current order
    final temporalOrderProvider = TemporalOrderProvider();

    //check the user name
    final userName = UserProvider();
    //checking the user data save in device
    final prefs = new PreferenciasUsuario();
    temporalOrderProvider.getBarberAsigned();
    userName.getName(prefs.token);
    //initialize the push notification provider
    pushProvider.initNotifications();
    pushProvider.messages.listen((data) {
      print(data);
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
          debugShowCheckedModeBanner: false,
          initialRoute: _rute(),
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

            // 'userInfo' : (context)=> User()
          },
        ));
  }

  _rute<String>() {
    final prefs = new PreferenciasUsuario();
    final checkUserOrder = CheckUserOrder();
    var res = checkUserOrder.checkUserOrder();

    print(prefs.order);
    if (prefs.token != '') {
      var ruta = 'services';
      print('entre1');
      res.then((response) async {
        if (response['content'] == 1) {
          ruta = 'services';
          print('servicio');
          prefs.order = 0.toString();
        } else {
          ruta = 'orderProccess';
          print('servicio1');
        }
      });

      print(ruta);
      return ruta;
    } else {
      return 'login';
    }
  }
}
