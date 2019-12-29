import 'package:flutter/material.dart';
import 'package:timugo/src/models/barbers_model.dart';
import 'package:timugo/src/services/number_provider.dart';
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
            height: 330,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.5),
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
  final url ='http://167.172.216.181:3000/';
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
            left: 10,
            child:Column(
              children:<Widget>[
                CircleAvatar(
                    radius:80.0,
                    backgroundImage:NetworkImage(url+prod.urlImg),
                    backgroundColor: Colors.black,
                ),
                Text(prod.name,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold))
              ],
            )
          )
        ],
      ),
    );
  }
}


   