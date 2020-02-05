import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';


class PushNotificationProvider {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _messagesStreamController = StreamController<String>.broadcast();
  final prefs = new PreferenciasUsuario();
  Stream<String>get messages => _messagesStreamController.stream;

  initNotifications(){
    
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token){
      print('Token');
      print(token);
      prefs.tokenPhone=token.toString();

      
    });

    _firebaseMessaging.configure(
      onMessage: (info) async { //when the app is dead and the notification appears
        print('======= oN MESSAGE ======');
        print(info);
        String argument = 'no-data';
        if( Platform.isAndroid ){
          argument = info['data']['phone'] ?? 'no-data';
        }
        _messagesStreamController.sink.add(argument);
      },
      onLaunch: (info) async { 
        print('======= oN Launch ======');
        print(info);
      },
      onResume: (info) async { //when the app is running in backgraound and the notification appears in drop menu
        print('======= oN Resume ======');
        print(info);
        
        final noti = info['data']['number'];
        print(noti);
      }
    );


  }

  dispose(){
    _messagesStreamController?.close();
  }
}