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
                image: AssetImage('assets/images/barber.png'),
                fit: BoxFit.cover
              )
            ),
          ),

          ListTile(
            leading: Icon( Icons.pages, color: Colors.blue ),
            title: Text('Home'),
        //    onTap: ()=> Navigator.pushReplacementNamed(context, HomePage.routeName ) ,
          ),

          ListTile(
            leading: Icon( Icons.party_mode, color: Colors.blue ),
            title: Text('Party Mode'),
            onTap: (){ },
          ),

          ListTile(
            leading: Icon( Icons.people, color: Colors.blue ),
            title: Text('People'),
            onTap: (){ },
          ),

          ListTile(
            leading: Icon( Icons.settings, color: Colors.blue ),
            title: Text('Settings'),
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