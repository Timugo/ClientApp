import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timugo/src/models/services_model.dart';
import 'package:timugo/src/pages/checkin_page.dart';
import 'package:timugo/src/providers/user.dart';
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
            height: 330,
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
    final userInfo   = Provider.of<UserInfo>(context);
    userInfo.urlImg = prod.urlImg;

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
            child: Image.network(url+prod.urlImg,width: 250,height: 200),
            
            //child: Image.network(url+prod.urlImg,width: 210,)
          )

        ],
      ),
    );
  }
}

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
                  
                      child:RaisedButton(
                        color: Colors.red,
                      child:Text('Solicitar',style: TextStyle(color: Colors.white)),
                      onPressed: (){
                   Navigator.push(
                   context,MaterialPageRoute(
                   builder: (context) => Checkin(model:prod)));
                      }
                      ),
                  
                    width: 100.0,
                    height: 35,
                    decoration:BoxDecoration(
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