import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';



class MenuWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/baner.jpg'),
                fit: BoxFit.cover
              )
            ),
          ),


          ListTile(
            leading: Icon( Icons.people, color: Colors.blue ),
            title: Text('Datos del perfil'),
            onTap:   () {showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: new Text("Servicio proximamente"),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Cerrar"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
              );
            }
          ),
          ListTile(
            leading: Icon( Icons.settings, color: Colors.blue ),
            title: Text('Contactanos'),
            onTap: (){
              _launchURL();
            },
          ),

        ],
      ),
    );
  }

}

_launchURL() async {
  const url = 'https://wa.me/573106838163?text=Hola%20soy%20Nombre%20Necesito%20asistencia%20con%20Timugo';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

