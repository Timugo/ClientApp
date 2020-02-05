import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timugo/src/pages/services_page.dart';
class AppBarCheckin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
       margin:  EdgeInsets.only(top: 40 ),
      width: double.infinity,
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
                        SizedBox(width: 15.0,),
                        IconButton(icon:Icon(FontAwesomeIcons.arrowLeft,size: 25.0,color: Colors.black),onPressed: (){
                             Navigator.push(
                   context,MaterialPageRoute(
                   builder: (context) => Services())
                ); 
                        },), 
                        Spacer()

        ],
      ),
    );
  }
}
  

