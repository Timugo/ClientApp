// Flutter dependencies
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Plugins
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timugo/src/pages/Login/application/login_page.dart';
// Pages
//import 'package:timugo/src/pages/Payment.dart';
import 'package:timugo/src/pages/menudrawer/widgets/userprofile_widget.dart';
// User Preferences
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
//Services
import 'package:timugo/src/services/number_provider.dart';
//Widgets
import 'package:timugo/src/widgets/toastMessage.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'Payment.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar.dart';

//MENU DRAWER CLASS
class MenuWidget extends StatelessWidget {
  final TextEditingController feedController = new TextEditingController();
  final border = Border.all(color: Colors.grey[200]);
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
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hola!',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300)
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      prefs.name[0].toUpperCase() + prefs.name.substring(1),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ]
              )
            ),
          ),
          Container(
            decoration : BoxDecoration(border: border),
            child : ListTile(
              leading: Icon(
                FontAwesomeIcons.user,
                color: Colors.black,
              ),
              title: Text(
                'Datos del perfil',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoPage()
                  )
                );
              }
            ),
          ),
          //  redirect to whatsapp  with  a message that content the name.
          Container(
            decoration : BoxDecoration(border: border),
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.headset,
                color: Colors.black,
              ),
              title: Text('Centro de ayuda '),
              onTap: _whatsappSupport()
            ),
          ),
          Container(
            decoration : BoxDecoration(border: border ),
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.comment,
                color: Colors.black,
              ),
              title: Text('Sugerencias'),
              onTap: () => _sendCommet(context)
            )
          ),
          Container(
            decoration : BoxDecoration(border: border),
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.thumbsUp,
                color: Colors.black,
              ),
              title: Text('Calificanos'),
              onTap: _launchURL
            ),
          ),
          Container(
            decoration: BoxDecoration(border: border),
            child:ListTile(
              leading: Icon(Icons.close,color: Colors.black,),
              title: Text('Cerrar Sesion'),
              onTap:(){
                Navigator.push(
                  context,MaterialPageRoute(
                    builder: (context) => LoginPage()
                  )
                );
              }
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(border: border),
          //   child:ListTile(
          //     leading: Icon(FontAwesomeIcons.creditCard,color: Colors.black,),
          //     title: Text('Métodos de pago'),
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

  _whatsappSupport() async {
    var whatsappUrl =
      "whatsapp://send?phone=${573106838163}?text=Hola mi nombre es " +
      prefs.name +" y necesito ayuda con mi orden de Timugo'";
    canLaunch(whatsappUrl)
      .then((value) => launch(whatsappUrl))
      .catchError((onError) =>showToast("Ups.. ocurrio un error. Estamos solucionandolo", Colors.blueAccent));
  }

  _launchURL() async {
    var url ;
    if (Platform.isAndroid) {
      // Android-specific code
      url ='https://play.google.com/store/apps/details?id=com.timugo.timugo_client_app';
    } else if (Platform.isIOS) {
      // iOS-specific code
      url = 'https://apps.apple.com/us/app/timugo/id1490734184';
      
    }
    //Launch the webview
    canLaunch(url)
      .then((value) => launch(url))
      .catchError((onError) =>throw 'Could not launch $url' );
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
              _sendFeedback(context);
            },
            child: Text(
              "Enviar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  void _sendFeedback(context) {
    final sendFeed = SendFeedBack();
    sendFeed.sendFeedBack(feedController.text)
      .then((response) {
        if (response.statusCode == 200) {
          Navigator.pop(context);
        }else{
          //Temporal fix
          Navigator.pop(context);
          showToast("Gracias por ayudarnos a mejorar", Color(0xFF0570E5));
          print("error al enviar el feedback");
        }
      })
      .catchError((onError){
        print("Error al enviar feedback"+onError);
      });
  }
}
