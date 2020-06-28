import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
//import 'package:timugo/src/pages/Payment.dart';
import 'package:timugo/src/pages/userInfo_pages.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

//import 'Payment.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';

//MENU DRAWER CLASS
class MenuWidget extends StatelessWidget {
  final TextEditingController feedController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    // funcion that return the name and pts of user
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Hola!',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300)),
                  ),
                  SizedBox(height: 30.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      prefs.name[0].toUpperCase() + prefs.name.substring(1),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ])),
          ),
          new CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 10.0,
            percent: 0.8,
            header: new Text(prefs.pts + ' ' + 'pts',
                style: TextStyle(fontWeight: FontWeight.bold)),
            center: new IconButton(
              icon: Icon(FontAwesomeIcons.gem),
              iconSize: 30.0,
              color: Colors.blue,
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Proximamente obtendras beneficios con tus puntos",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 14.0);
              },
            ),
            backgroundColor: Colors.white,
            progressColor: Colors.blue,
          ),
          // content the perfil data and  go to page info user
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey[200])),
            child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.user,
                  color: Colors.black,
                ),
                title: Text(
                  'Datos del perfil',
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserInfoPage()));
                }),
          ),
          //  redirect to whatsapp  with  a message that content the name.
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey[200])),
            child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.headset,
                  color: Colors.black,
                ),
                title: Text('Centro de ayuda '),
                onTap: () async {
                  var whatsappUrl =
                      "whatsapp://send?phone=${573106838163}?text=Hola mi nombre es " +
                          prefs.name +
                          " y necesito ayuda con mi orden de Timugo'";
                  await canLaunch(whatsappUrl)
                      ? launch(whatsappUrl)
                      : print("No se encontro el link o whatsapp no instalado");
                }),
          ),
          Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.grey[200])),
              child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.comment,
                    color: Colors.black,
                  ),
                  title: Text('Sugerencias'),
                  onTap: () {
                    _sendCommet(context);
                  }
                  //     FlutterOpenWhatsapp.sendSingleMessage("573162452663", "Hola, me gustaría que Timugo...");
                  // }
                  )),
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey[200])),
            child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.thumbsUp,
                  color: Colors.black,
                ),
                title: Text('Calificanos'),
                onTap: () {
                  _launchURL();
                }),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //    border: Border.all( color: Colors.grey[200])),
          //   child:ListTile(
          //     leading: Icon(FontAwesomeIcons.creditCard,color: Colors.black,),
          //     title: Text('Métodos de pago',),
          //     onTap:(){
          //       Navigator.push(
          //         context,MaterialPageRoute(
          //         builder: (context) => Payment()));
          //     }
          //   ),
          // ),
        ],
      ),
    );
  }

  _launchURL() async {
    if (Platform.isAndroid) {
      // Android-specific code
      const url =
          'https://play.google.com/store/apps/details?id=com.timugo.timugo_client_app';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else if (Platform.isIOS) {
      const url = 'https://apps.apple.com/us/app/timugo/id1490734184?ls=1';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
      // iOS-specific code
    }
  }

  _sendCommet(context) {
    Alert(
        context: context,
        title: "COMENTARIOS",
        content: Column(
          children: <Widget>[
            Container(
              height: 200,
              color: Color(0xffeeeeee),
              padding: EdgeInsets.all(10.0),
              child: new ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 200.0,
                ),
                child: new Scrollbar(
                  child: new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    child: SizedBox(
                      height: 190.0,
                      child: new TextField(
                        controller: feedController,
                        maxLines: 100,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Escribe tu comentario aquí',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              final sendFeed = SendFeedBack();
              var res = sendFeed.sendFeedBack(feedController.text);
              res.then((response) async {
                if (response['response'] == 2) {
                  Navigator.pop(context);
                }
              });
            },
            child: Text(
              "Enviar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

//  _sendCalification(context){
//  Alert(
//         context: context,
//         title: "Califica tu experiencia",
//         content: Column(
//           children: <Widget>[
//             Container(
//             height: 200,
//             color: Color(0xffeeeeee),
//             padding: EdgeInsets.all(10.0),
//             child: new ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxHeight: 200.0,
//               ),
//               child: new Scrollbar(
//                 child: new SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   reverse: true,
//                   child: SizedBox(
//                     height: 190.0,
//                     child: RatingBar(
//                   initialRating: 3,
//                   itemCount: 3,
//                   itemBuilder: (context, index) {
//                     switch (index) {
//                         case 0:
//                           return Icon(
//                               Icons.mood_bad,
//                               color: Colors.red,
//                           );
//                         case 1:
//                           return Icon(
//                               Icons.sentiment_neutral,
//                               color: Colors.yellow,
//                           );
//                         case 2:
//                           return Icon(
//                               Icons.sentiment_very_satisfied,
//                               color: Colors.green,
//                           );

//                     }
//                   },
//                   onRatingUpdate: (rating) {
//                     print(rating);
//                   },
//                     )
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           ],
//         ),
//         buttons: [
//           DialogButton(
//             onPressed: (){
//              final sendFeed =SendFeedBack();
//              var res = sendFeed.sendFeedBack(feedController.text);
//              res.then((response) async {
//              if (response['response'] == 2){
//                Navigator.pop(context);
//               }});
//             },
//             child: Text(
//               "Enviar",
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//           )
//         ]).show();

//   }

}
