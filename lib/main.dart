//Flutter dependencies
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//User dependencies
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/providers/push_notifications_provider.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
//pages 
import 'package:timugo/src/pages/codeVerification_page.dart';
import 'package:timugo/src/pages/login_pages.dart';
import 'package:timugo/src/pages/registerData_page.dart';
import 'package:timugo/src/pages/services_page.dart';



void main() async{
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
  @override
  void initState() {
    super.initState();
    final pushProvider = PushNotificationProvider(); 
    pushProvider.initNotifications();
    pushProvider.messages.listen((argument){
      print("Argumento");
      print(argument);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( builder: (context) => UserInfo() ),
        ChangeNotifierProvider( builder: (context) => ServicesProvider() ),
      ],
      child: MaterialApp(
      
        debugShowCheckedModeBanner: false,
        initialRoute:_rute(),
        routes: {
          'login':(context)=> LoginPage(),
          'code':(context)=> Code(),
          'registerData':(context)=> RegisterData(),
          'services':(context)=> Services(),
        },
       
      )
    );
  }

  _rute<String> () {
    final prefs = new PreferenciasUsuario();
    print(prefs.token);
    if (prefs.token!='') {
      var ruta='services';
      return ruta;
    }else{
      return 'login';
    }



  }
}
