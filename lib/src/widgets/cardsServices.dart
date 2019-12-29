import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timugo/src/models/services_model.dart';
import 'package:timugo/src/services/number_provider.dart';

class CardsServices extends StatelessWidget {
  const CardsServices({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final servicesProvider = ServicesProvider();

    return FutureBuilder(
      future: servicesProvider.getServices(),
      builder: (BuildContext context, AsyncSnapshot<List<ServicesModel>> snapshot) {  
        if ( snapshot.hasData ) {
          final productos = snapshot.data;
          return Container(
            width: size.width,
            height: 290,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.7),
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
  
 final  ServicesModel prod;
  _Card(this.prod);
   final url ='http://167.172.216.181:3000/';
  
  @override
  Widget build(BuildContext context) {
    print('estoy acacss'+prod.urlImg);
    return Container(
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
           //   _FirstDescription(prod),//lateral bar with description
              SizedBox(width: 10.0),
              _DescriptionCard(prod),
            ],
          ),
         
          Positioned(
            top: 5,
            left: -20,
            child: Image.network(url+prod.urlImg,width: 210,)
            
            //child: Image.network(url+prod.urlImg,width: 210,)
          )

        ],
      ),
    );
  }
}

// class _FirstDescription extends StatelessWidget {
//    final ServicesModel prod;
//    _FirstDescription (this.prod);
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(10.0),
//       child: RotatedBox(
//         quarterTurns: 3,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Icon(FontAwesomeIcons.cut,size: 15,),
//             SizedBox(width: 10.0,),
//             Text('${prod.price}-Incluye perfilado de cejas',style: TextStyle(fontSize: 12.0),),
            
//             SizedBox(width:30.0),
             
//             Icon(FontAwesomeIcons.smileBeam,size: 15,),
//             SizedBox(width: 10.0,),
//             Text("Clasico",style: TextStyle(fontSize: 12.0),),
            
            
//           ],
//         ),
//       ),
//     );
//   }
// }

class _DescriptionCard extends StatelessWidget {
  final ServicesModel prod;
 
  _DescriptionCard (this.prod);

 
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
          color : Color(0xff000000),
          child: Column(

            children: <Widget>[

              SizedBox(height: 25.0,),

              RotatedBox(
                quarterTurns: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('Style',style: TextStyle(color: Colors.white24,fontSize: 30,fontWeight: FontWeight.bold)),

                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Text('${prod.name}',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold)),
                    Spacer(),
                    Icon(FontAwesomeIcons.heart,color: Colors.white),
                     
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: Text('\$'+'${prod.price}',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
                    width: 60,
                  ),
                  Container(
                    child: Center(
                      child: Text('Solicitar',style: TextStyle(color: Colors.white)),
                    ),
                    width: 100.0,
                    height: 35,
                    decoration:BoxDecoration(
                      color:Colors.red,
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