import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
                        SizedBox(width: 15.0,),
                        IconButton(icon:Icon(FontAwesomeIcons.userCircle,size: 25.0,color: Colors.black),onPressed: (){},), 
                        Spacer(),
                        Stack(
                          children: <Widget>[
                          IconButton(icon:Icon(FontAwesomeIcons.headset,color: Colors.black,),onPressed: (){},),
                          Container(
                            child: Center(child: Text('1',style: TextStyle(color: Colors.white ),)),
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20.0)
                            ),
                          )

                          ],
                        ),
                        Icon(FontAwesomeIcons.ellipsisV,size: 15.0,color: Colors.black), 
                        IconButton(icon:Icon(FontAwesomeIcons.ticketAlt,size: 15.0,color: Colors.black),onPressed: (){},), 
                        SizedBox(width: 8.0,)


        ],
      ),
    );
  }
}

