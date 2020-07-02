import 'package:flutter/material.dart';
import 'package:timugo/src/pages/homeservices/application/services_page.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';

// Class that  contains  the user info
class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoState createState() {
    return new _UserInfoState();
  }
}

class _UserInfoState extends State<UserInfoPage> {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Services()));
            },
          ),
          backgroundColor: Colors.grey[200],
        ),
        // contains the  title of page ' datos del perfil'
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
          Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
              ),
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: Row(
                children: <Widget>[
                  Text("Mi perfil",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                            'https://www.municipalidaddeitaugua.gov.py/application/files/5415/5270/0823/user.png'), // this img  url is any  in the internet
                        radius: 40),
                  ),
                ],
              )),

          _user(),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(
                bottom: size.height * 0.04, top: size.height * 0.8),
            child: RaisedButton(
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.green)),
              color: Colors.green.shade500,
              padding: EdgeInsets.fromLTRB(size.width * 0.3,
                  size.height * 0.020, size.width * 0.3, size.height * 0.020),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Services()));
              },
              child: Text(
                'Guardar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ) //  call te widget that paint  the user info
        ])));
  }

  // widget that   paint  in List Tile the  user informations
  Widget _user() {
    //   final size = MediaQuery.of(context).size;
    //String nombre='hola';
    return Stack(children: <Widget>[
      Container(
          margin: EdgeInsets.only(top: 100, left: 15, right: 15, bottom: 100),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]),
            borderRadius: BorderRadius.all(
                Radius.circular(20.0) //                 <--- border radius here
                ),
          ),
          child: Container(
              margin: EdgeInsets.only(top: 35),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    MyTextFormField(
                      text: Icon(Icons.person),
                      hintText: prefs.name,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Digita un nombre';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        print('entre');
                      },
                    ),
                    MyTextFormField(
                      keyboardType: TextInputType.number,
                      text: Icon(Icons.call),
                      hintText: prefs.token,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Digita un nombre';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        print('entre');
                      },
                    ),
                    MyTextFormField(
                      onTap: true,
                      keyboardType: TextInputType.emailAddress,
                      text: Icon(
                        Icons.email,
                        color: Colors.red,
                      ),
                      hintText: prefs.email,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Digita un nombre';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        print('entre');
                      },
                    ),
                    //     leading: Icon(Icons.person,color: Colors.black,),
                    //     title: Text(prefs.name,),
                    //     onTap: () => Navigator.pushNamed(context,null),
                    //   ),
                    //   ListTile(
                    //     leading: Icon(Icons.call,color: Colors.black,),
                    //     title: Text(prefs.token,),
                    //     onTap: () => Navigator.pushNamed(context,null),
                    //   ),
                    //   //  redirect to whasapp  with  a message that content the name.
                    //   ListTile(
                    //     leading:  Icon(Icons.email,color: Colors.black,),
                    //     title: Text(prefs.email),
                    //     onTap: (){}
                    //   ),
                    // ],
                  ])))
    ]);
  }
}

class MyTextFormField extends StatelessWidget {
  final Icon text;
  final String hintText;
  final Function validator;
  final Function onSaved;
  final TextInputType keyboardType;
  final bool onTap;

  MyTextFormField({
    this.text,
    this.hintText,
    this.validator,
    this.onSaved,
    this.keyboardType,
    this.onTap = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.02,
          right: size.width * 0.02,
          bottom: 10,
          top: size.width * 0.05),
      child: TextFormField(
        enabled: onTap ? false : true,
        decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            prefixIcon: text,
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            )),
        validator: validator,
        onSaved: onSaved,
        keyboardType: keyboardType,
      ),
    );
  }
}
