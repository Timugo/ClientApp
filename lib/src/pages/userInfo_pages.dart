
import 'package:flutter/material.dart';
import 'package:timugo/src/pages/services_page.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';

// Class that  contains  the user info 
class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoState createState() 
  {
    return new  _UserInfoState();} 
}

class _UserInfoState extends State<UserInfoPage> {
  final prefs = new PreferenciasUsuario();
  
  @override
   
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         elevation: 0,
         leading: new IconButton(
               icon: new Icon(Icons.arrow_back, color: Colors.black,size: 35,),
               onPressed: () {
                Navigator.push(
                  context,  
                  MaterialPageRoute(
                    builder: (context) => Services()
                  )
                );
               },
         ),
        backgroundColor: Colors.white10,
       ),
      // contains the  title of page ' datos del perfil'
      body:Stack( 
        children:<Widget>[
          Container(
            padding:EdgeInsets.only(left: 15,top: 60) ,
            child:Text("Datos de perfil",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold)),
          ),
           
          _user(),  //  call te widget that paint  the user info
        ]
      )
    );
  }
  // widget that   paint  in List Tile the  user informations
  Widget _user(){
    final size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top:size.height*0.15),
            child:Row(
              children: <Widget>[
                CircleAvatar(
                  radius:75.0,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                  backgroundImage:NetworkImage( 'https://www.municipalidaddeitaugua.gov.py/application/files/5415/5270/0823/user.png' ), // this img  url is any  in the internet
                  radius:65
                  ),
                ),
              ]
            )
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             ListTile(
              leading: Icon(Icons.person,color: Colors.black,),
              title: Text(prefs.name,),
              onTap: () => Navigator.pushNamed(context,null),
            ),
            ListTile(
              leading: Icon(Icons.call,color: Colors.black,),
              title: Text(prefs.token,),
              onTap: () => Navigator.pushNamed(context,null),
            ),
            //  redirect to whasapp  with  a message that content the name.
            ListTile(
              leading:  Icon(Icons.email,color: Colors.black,),
              title: Text(prefs.email),
              onTap: (){}
            ),
          ],

        ) 
      
      ]
    );
}
}

