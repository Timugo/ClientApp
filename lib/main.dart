import 'package:flutter/material.dart';
import 'package:timugo_client_app/pages/login_pages.dart';
import 'package:timugo_client_app/pages/register.dart';
import 'package:timugo_client_app/pages/services.pages.dart';
import 'package:timugo_client_app/providers/providers.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login':(BuildContext context ) => Login(),
          'register':(BuildContext context ) => Register(),
          'services':(BuildContext context ) => Services()
        },
        title: 'Material App',
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      
      )
    );
  }
}

