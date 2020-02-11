import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:timugo/src/pages/userInfo_pages.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:url_launcher/url_launcher.dart';


//MENU DRAWER CLASS 
class MenuWidget extends StatelessWidget {

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
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30.0),
                  Align(alignment: Alignment.centerLeft,child: Text('Hola!', style: TextStyle( color: Colors.black, fontSize: 20.0,fontWeight:FontWeight.w300 )),),
                  SizedBox(height: 30.0),
                  Align(alignment: Alignment.centerLeft,child: Text(prefs.name[0].toUpperCase() + prefs.name.substring(1), style: TextStyle( color: Colors.black, fontSize: 35.0 , fontWeight: FontWeight.bold ),),),
                ]
              )
            ),
          ),
          new CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 10.0,
            percent: 0.8,
            header: new Text(prefs.pts+' ' +'pts',style: TextStyle(fontWeight:  FontWeight.bold)),
            center: new IconButton(
              icon:Icon(FontAwesomeIcons.gem),
              iconSize: 30.0,
              color: Colors.blue,
              onPressed: (){
                Fluttertoast.showToast(
                  msg: "Proximamente obtendras beneficios con tus puntos",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 14.0
                );
              },
            ),
            backgroundColor: Colors.white,
            progressColor: Colors.blue,
          ),
          // content the perfil data and  go to page info user
          ListTile(
            leading: Icon(FontAwesomeIcons.user,color: Colors.black,),
            title: Text('Datos del perfil',),
            onTap:(){
              Navigator.push(
                context,MaterialPageRoute(
                builder: (context) => UserInfoPage()));

            }       
          ),
          //  redirect to whatsapp  with  a message that content the name.
          ListTile(
            leading:  Icon(FontAwesomeIcons.headset,color: Colors.black,),
            title: Text('Centro de ayuda '),
            onTap: (){
                FlutterOpenWhatsapp.sendSingleMessage("573162452663", "Hola mi nombre es "+prefs.name+' y necesito ayuda con Timugo');
            }
          ),
           ListTile(
            leading:  Icon(FontAwesomeIcons.comment,color: Colors.black,),
            title: Text('Sugerencias'),
            onTap: (){
                FlutterOpenWhatsapp.sendSingleMessage("573162452663", "Hola, me gustaría que Timugo...");
            }
          ),
           ListTile(
            leading:  Icon(FontAwesomeIcons.comment,color: Colors.black,),
            title: Text('Calificanos'),
            onTap: (){
            _launchURL();
            }
          ),
          
        ],
      ),
    );
  }
  _launchURL() async {
  const url = 'https://play.google.com/store/apps/details?id=com.timugo.timugo_client_app';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

}