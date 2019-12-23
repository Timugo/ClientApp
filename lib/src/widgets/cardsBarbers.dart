import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              _FirstDescription(),
              SizedBox(width: 10.0),
              _DescriptionCard(),
            ],
          ),

          Positioned(
            top: 35,
            left: 10,
            child: Image.network('https://shorebeautyschool.edu/wp-content/uploads/2018/05/Barber-Beard-Slider-5-2.png',width: 210,)
          )

        ],
      ),
    );
  }
}

class _FirstDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: RotatedBox(
        quarterTurns: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(FontAwesomeIcons.cut,size: 15,),
            SizedBox(width: 10.0,),
            Text("Incluye perfilado de cejas",style: TextStyle(fontSize: 12.0),),
            
            SizedBox(width:30.0),
             
            Icon(FontAwesomeIcons.smileBeam,size: 15,),
            SizedBox(width: 10.0,),
            Text("Clasico",style: TextStyle(fontSize: 12.0),),
            
            
          ],
        ),
      ),
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(  
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width:size.width * 0.50 ,
          height: 270.0,
          color : Color(0xff0B3FA2),
          child: Column(

            children: <Widget>[

              SizedBox(height: 25.0,),

              RotatedBox(
                quarterTurns: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('Urban Style',style: TextStyle(color: Colors.white24,fontSize: 30,fontWeight: FontWeight.bold)),

                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Text('Corte de Cabello',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold)),
                    Spacer(),
                    Icon(FontAwesomeIcons.heart,color: Colors.white)
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Text('\$ 15.000',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
                    width: 80,
                  ),
                  Container(
                    child: Center(
                      child: Text('Solicitar',style: TextStyle(color: Colors.white)),
                    ),
                    width: 100.0,
                    height: 35,
                    decoration:BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15))

                    ) ,
                    
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );  
  }
}