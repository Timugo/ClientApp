import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:percent_indicator/percent_indicator.dart';
class PointWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
       final prefs = new PreferenciasUsuario();
       final size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar: AppBar(
         elevation: 0,
         leading: new IconButton(
               icon: new Icon(Icons.arrow_back, color: Colors.black,size: 35,),
               onPressed: () => Navigator.of(context).pop(),
              ),
        backgroundColor: Colors.white10,
       ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top:100,left: 40),
          child:Row(

             children: <Widget>[
      
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child:
            CircleAvatar( 
              radius: 45,
              backgroundColor: Colors.orange,
              child:Icon(FontAwesomeIcons.gem,color: Colors.white,size: 30,),)

          ),
          Text(prefs.pts+'pts',style: TextStyle( color: Colors.black, fontSize: 35.0,fontWeight: FontWeight.bold ))
             ]
          ),
          ),
          Row(
            children: <Widget>[
              Padding(
              padding: EdgeInsets.only(left:15.0,top:240,right: 15),
              child: new LinearPercentIndicator(
                width: size.width*0.8,
                lineHeight:15,
                percent: int.parse(prefs.pts)*1.0,
                center: Text(
                  prefs.pts+'pts',
                  style: new TextStyle(fontSize: 12.0),
                ),
                trailing: Icon(FontAwesomeIcons.cut),
                linearStrokeCap: LinearStrokeCap.roundAll,
                backgroundColor: Colors.white,
                progressColor: Colors.blue,
              ),
            ),
            ],

          ),
          new Container(height: 1,  color: Colors.blue,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0,top: 280),)
          
        
              
        //       IconButton(
        //         icon:Icon(Icons.add),
        //         onPressed: (){},
        //       ),

        //     ],

        //   ),
         
         ],

      )
    );
  }
 
}