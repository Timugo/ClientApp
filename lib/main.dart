
import 'package:flutter/material.dart';
import 'package:timugo_client_app/pages/birt.dart';
import 'package:timugo_client_app/pages/feedBack_pages.dart';
import 'package:timugo_client_app/pages/login_pages.dart';
import 'package:timugo_client_app/pages/notifications.dart';
import 'package:timugo_client_app/pages/order_pages.dart';
import 'package:timugo_client_app/pages/recent_transaction_pages.dart';
import 'package:timugo_client_app/pages/register_pages.dart';
import 'package:timugo_client_app/pages/services_pages.dart';
import 'package:timugo_client_app/providers/providers.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return Provider(
    child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: 'login',
          routes: {
              'login':(BuildContext context ) => Login(),
              'register':(BuildContext context ) => Register(),
              'services':(BuildContext context ) => Service(),
              'order': (BuildContext context ) => Order(),
              'notificaciones': (BuildContext context ) => NotificationsPage(),
              'feed'  :  (BuildContext context ) => FeedBack(),
              'transaction'  :  (BuildContext context ) => RecentTransactionsPage(),
              },
          title: 'Material App',
          theme: ThemeData(
          primaryColor: Colors.deepPurple
          ),
        ),
    );
    }
}