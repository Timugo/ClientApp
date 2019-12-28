import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardsBarbers extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 330,
      child: PageView(
        controller: PageController(viewportFraction: 0.67),
        children: <Widget>[
          _Card(),
          _Card(),
          _Card(),
          _Card(),
          
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
            //  _FirstDescription(),
              SizedBox(width: 10.0),
             // _DescriptionCard(),
            
            ],
          ),

          Positioned(
            top: 35,
            left: 10,
            child:Column(
            
            children:<Widget>[
            CircleAvatar(
                radius:80.0,
                backgroundImage:
                    NetworkImage('https://shorebeautyschool.edu/wp-content/uploads/2018/05/Barber-Beard-Slider-5-2.png')
                    ,
                backgroundColor: Colors.black,
                
              ),
              Text('Barbero',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold))
              ],
            )
//child: Image.network('https://shorebeautyschool.edu/wp-content/uploads/2018/05/Barber-Beard-Slider-5-2.png',width: 210,)
          )
           

        ],
      ),
    );
  }
}


   