import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';


class PushNotificationProvider {
  
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final _messagesStreamController = StreamController<String>.broadcast();
  final prefs = new PreferenciasUsuario();
  Stream<String>get messages => _messagesStreamController.stream;

  initNotifications(){
    //getting permission to the user ios/android for send push notifications 
    _firebaseMessaging.requestNotificationPermissions();
    //gettinh token from the phone token -> return future
    _firebaseMessaging.getToken().then((token){
      print('=========FCM TOKEN ==========');
      print(token);
      //save token in the prefs (local db in device)
      prefs.tokenPhone=token.toString();
      print(prefs.tokenPhone);
    });

    //Configuring the different cases to recieve push notifications 
    _firebaseMessaging.configure(
      onMessage: (info) async { 
        //when the app is open 
       // print('======= ON MESSAGE ======');
        //print(info);
        _showMessa(info['notification']['body']);

       

       
        String argument = 'no-data';
        //catching data from push notification body example
        // {
        //   "to":"dx8CdHAq7ExOu77tdJ0GRC:APA91bEHr6SvWosDqShhi0AXRwL6nUceamz2Mce78AghcyZSXqIfOt0u510Q-flagHnc6HLSm2iNtQSjGvp_S1UfpJ94YncP7KWnLi8_7mwCHLbwyvScbWRK3SR-gGMubidZQ8IJjZYA",
        //   "notification":{
        //     "title":"Putoooo",
        //     "body":"Puto el que lo lea xD"
        //   },
        //   "data":{
        //     "phone":"3188758481"
        //   }
          
        // }
        if( Platform.isAndroid ){
          argument = info['data']['phone'] ?? 'no-data';

        }else{
          //platform ios
          argument = info['phone'] ?? 'no-data-ios';
        }
        
        _messagesStreamController.sink.add(argument);
      },
      onLaunch: (info) async { 
        //when the app is running in the background (still alive)
        print('======= ON Launch ======');
        print(info);
      },
      onResume: (info) async { 
        //when the app is dead in the foreground
        print('======= ON Resume ======');
        print(info);
        
        String noti = info['data']['number'];
        print(noti);
      }
    );


  }
  _showMessa(  info){ // show the toast message in bell appbar
    Fluttertoast.showToast(
      msg:info,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIos: 1,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 14.0
    );

  }
 

  dispose(){
    _messagesStreamController?.close();
  }
}