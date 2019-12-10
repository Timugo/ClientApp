import 'package:flutter/material.dart';
import 'package:timugo_client_app/providers/sqlite_providers.dart';

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

Future getClients() async {
  
  var list = ClientDB.db.getClient();
  list.then((res) async {
    print(res[0].name);
    var url = 'https://wa.me/573106838163?text=Hola%20soy%20' + res[0].name + '%20identificado%20con%20el%20código%20' + res[0].id.toString() + '%20y%20necesito%20ayuda%20con%20Timugo.%20Gracias';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    } 
  });
}

_launchURL() async {
  getClients();           
}

