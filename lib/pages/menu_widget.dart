import 'package:flutter/material.dart';




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
            onTap: () => Navigator.pushNamed(context,null),
          ),

          ListTile(
            leading: Icon( Icons.settings, color: Colors.blue ),
            title: Text('Contactanos'),
            onTap: (){
              // Navigator.pop(context);
             // Navigator.pushReplacementNamed(context, SettingsPage.routeName  );
            }
          ),

        ],
      ),
    );
  }
}