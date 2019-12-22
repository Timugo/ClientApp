import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timugo/src/widgets/cardsServices.dart';
import 'package:timugo/src/widgets/circularBackground.dart';

import 'package:timugo/src/widgets/customAppbar.dart';
 

 
class Services extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: <Widget>[
          
          CircularBackGround(),
          SafeArea(

            child: SingleChildScrollView(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomAppBar(),
                  _Header(),
                  CardsServices(),

                ],
              ) ,
            ),
          ),
          BuyButton()
        ],
      )
    ); 
    
  }
}

class  _Header extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start ,
        children: <Widget>[
          SizedBox(height: 45.0,),
          Text('Servicios',style:TextStyle(fontWeight:FontWeight.bold,fontSize:30.0)),
          Text('Que quieres pedir hoy?',style:TextStyle(fontWeight:FontWeight.w100,fontSize:18.0))

        ],
      ),
    );
  }
}

class BuyButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: Container(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Pedir',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
                SizedBox(width: 5.0,),
                Icon(FontAwesomeIcons.arrowRight,color: Colors.white,)
              ],
            ),
            width: size.width*0.3,
            height: 60.0,
            decoration: BoxDecoration(
              color:Colors.red,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0))
            ),
          ),
        )
      ],
    );
  }
}