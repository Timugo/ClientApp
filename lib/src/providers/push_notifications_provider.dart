import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';


class PushNotificationProvider {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _messagesStreamController = StreamController<String>.broadcast();
  Stream<String>get messages => _messagesStreamController.stream;

  initNotifications(){
    
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token){
      print('Token');
      print(token);
      //ewZR5RNreSw:APA91bEtSfbBcPBiNkALQxe_R498c4_aqJFav4M2Hqpvor9BQ7TyC6Wnmo6rIA_gZZIb2kmU-hooG2ZZLIhHOx1dgqNAjZDxHl87kpgKP3zO4Tv-g8sPlAZJkqAaXODTfT_hzDlxpesg 
      // eCrrUlR6XYM:APA91bFJv9NjXCa0pwthhsPwq1aW2a9jpzQBkciZbHkmKFTcJogaarRvOv2B-5n8XN7gOvPFspPLaucoxWUvO264jqnvogDeVElc1bNTGDlzkTfcSufZgv3BNiVmtrF9muGCNVNKo6KM
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