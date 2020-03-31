
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timugo/src/pages/menu_widget.dart';
import 'package:timugo/src/widgets/creditCard.dart';

class Payment extends StatelessWidget {
  const Payment({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  // final size = MediaQuery.of(context).size;
     return Scaffold(
       backgroundColor: Colors.grey[100],
       
       appBar: AppBar(
      
         elevation: 0,
         leading: new IconButton(
               icon: new Icon(Icons.arrow_back, color: Colors.black,size: 35,),
               onPressed: () {
                Navigator.push(
                  context,  
                  MaterialPageRoute(
                    builder: (context) => MenuWidget()
                  )
                );
               },
         ),
        backgroundColor: Colors.white,
       ),
      // contains the  title of page ' datos del perfil'
      body:Stack( 
        children:<Widget>[
          Container(
          decoration: BoxDecoration(
            color:Colors.white,
           borderRadius: BorderRadius.only(
             bottomRight: Radius.circular(20),
             bottomLeft: Radius.circular(20)
            ), 
          ),
             
            padding:EdgeInsets.only(left: 15,right: 15,bottom: 20) ,
            child:Row(
              children: <Widget>[
                Text("Tus métodos de pago",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w600)),

              ],


            )
          ),
        //    Container(
        //      margin:  EdgeInsets.only(top: size.height*0.05,bottom:size.height*0.1),
        //     child:FutureBuilder(
        //      // future: aditionalProvider.getAditional(model.id.toString()),
        //       builder: (BuildContext context, AsyncSnapshot<List<AditionalModel>> snapshot) {
        //         if ( snapshot.hasData ) {
        //           final productos = snapshot.data;
        //           return ListView.builder(
        //             key: UniqueKey(),
                    
        //             itemCount: productos.length,
        //             itemBuilder: (context, i) => ListTileItem()
                     
        //           );
        //         }else {
        //           return Center( child: CircularProgressIndicator());
        //         }
        //       },
        //     )
        //  )
        Container(
             margin: EdgeInsets.only(top:80,left: 15,right: 15),
        child:Text('Añadir método de pago',style:  TextStyle(color: Colors.greenAccent,fontSize: 15,fontWeight: FontWeight.bold ),),
        ),
          Container(
             margin: EdgeInsets.only(top:100,left: 15,right: 15,bottom: 200),
            decoration: BoxDecoration(
            color: Colors.white,
           borderRadius: BorderRadius.all(
             Radius.circular(10),
             
            ), 
          ),
           child: ListTile(
             title:Text('Tarjeta de crédito'),
            leading: Icon(FontAwesomeIcons.solidCreditCard,color: Colors.black,),
            trailing: Icon(FontAwesomeIcons.arrowRight,color: Colors.black,) ,
            onTap: (){
               Navigator.push(
                  context,MaterialPageRoute(
                  builder: (context) => CreditCardH()));

            },
           ),
          )
        ],
      )
    );
  }
}
