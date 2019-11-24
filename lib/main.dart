import 'package:flutter/material.dart';
import 'package:timugo_client_app/pages/login.dart';
import 'package:timugo_client_app/pages/register.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'register',
      routes: {
        'login':(BuildContext context ) => Login(),
        'register':(BuildContext context ) => Register(),
      },
      title: 'Material App',
     
    );
  }
}

