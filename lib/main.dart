
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timugo/src/pages/codeVerification_page.dart';
import 'package:timugo/src/pages/login_pages.dart';
import 'package:timugo/src/pages/registerData_page.dart';
import 'package:timugo/src/providers/push_notifications_provider.dart';
import 'package:timugo/src/providers/user.dart';


 
void main() => runApp(MyApp());
 
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
      
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login':(context)=> LoginPage(),
          'code':(context)=> Code(),
          'registerData':(context)=> RegisterData()
        
        },
      )
    );
      
      
      
    
  }
}
