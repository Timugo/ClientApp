import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardsBarbers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 230,
      child: PageView(
        controller: PageController(viewportFraction: 0.48),
        children: <Widget>[
          _Card(),
          _Card(),
          _Card(),
          _Card(),
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
              SizedBox(width: 10.0),
            ],
          ),
          Positioned(
            top: 35,
            left: 10,
            child:Column(
              children:<Widget>[
                CircleAvatar(
                    radius:80.0,
                    backgroundImage:NetworkImage('https://i.pinimg.com/originals/7a/46/90/7a4690d11a022d924e5ceae975b511a5.jpg'),
                    backgroundColor: Colors.black,
                ),
                Text('Barbero',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold))
              ],
            )
          )
        ],
      ),
    );
  }
}


   