import 'package:flutter/material.dart';
import 'package:timugo/src/models/barbers_model.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:timugo/globlas.dart' as globals;

import 'description.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardsBarbers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    final servicesProvider = BarbersProvider();

    return FutureBuilder(
      future: servicesProvider.getBarbers(),
      builder: (BuildContext context, AsyncSnapshot<List<BarbersModel>> snapshot) {  
        if ( snapshot.hasData ) {
          final productos = snapshot.data;
          return Container(
            width: size.width,
            height: 240,
            child: PageView.builder(
              controller: PageController(viewportFraction: size.width>size.height ? 0.25 : 0.50),
              pageSnapping: false,
              itemCount: productos.length,
              itemBuilder: (context, i) => _Card( productos[i] ), 
            ),
          );
        }else{
          return Center( child: CircularProgressIndicator());
        }
       }
    );
  } 
}

class _Card extends StatelessWidget {
  final  BarbersModel prod;
  final String  url = globals.url;
 
  _Card(this.prod);
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
            left: 0,
            child:Column(
              children:<Widget>[
                new RawMaterialButton(
                  onPressed:  () => _onButtonPressed(context,prod),
                shape: new CircleBorder(),
                child:CircleAvatar(
                    radius:80.0,
                    backgroundImage:NetworkImage(url+prod.urlImg),
                    backgroundColor: Colors.black,
                    
                )
                ),
                Text(prod.name,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold))
                ,
              ],
            )
          )
        ],
      ),
    );
  }

   
void _onButtonPressed(BuildContext context, BarbersModel prod) {
     final size = MediaQuery.of(context).size.height;
     print(prod.phone);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: size*0.4,
            child: Container(
              child: Description(prod),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          );
        });
  }
}


   