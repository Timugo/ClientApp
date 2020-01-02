import 'package:flutter/material.dart';
import 'package:timugo/src/widgets/addDirections.dart';

import 'checkin_page.dart';




class Checkout extends StatefulWidget {
  
  
  @override
  _CheckoutState createState() 
  {return new  _CheckoutState();} 
}

class _CheckoutState extends State<Checkout> {
  


   @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

     return Scaffold(
   
     
      body:Stack( 
        
    
        children:<Widget>[
          Container(
            padding: EdgeInsets.only(top:40),

            child:IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(
                   builder: (context) => Checkin()));
              },

            )
          ),
           ListView(
            children:<Widget>[
                Container(
         padding:EdgeInsets.only(left: 15,top: 80) ,
        child:Text("Checkout",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold)),
         ),
         Card(
           
           child:ListTile(

             title: Text('Dirección'),
             trailing:IconButton(
               icon: Icon(Icons.arrow_drop_down),
               onPressed: () => _onButtonPressed(context),
             ),
                          
           )
         ),
         Card(
          child: ListTile(
            title: Text('Tiempo Estimado',),
            trailing: Text('30 min',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                ),
          ),
          Card(
          child: ListTile(
            title: Text('Método de pago',),
            trailing:RaisedButton.icon(
              color: Colors.green,
              icon: Icon(Icons.attach_money),
              onPressed: (){},
              label: Text('Efectivo',style: TextStyle(fontSize: 20)),
              
            )
                ),
          ),
           SizedBox(height: 40,),
            
          Container(
            padding:EdgeInsets.only(left: 15,right: 15) ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Resumen',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 22)),
                ListTile(
                   contentPadding:EdgeInsets.only(left: 0),
                  title: Text('Costo del servicio :'),
                  trailing: Text('15.000'),
                ),
               
                ListTile(
                  contentPadding:EdgeInsets.only(left: 0),
                  title:Text('Costos adiccionales :') ,
                  trailing: Text('0'),
                ),
                
                  ListTile(
                  contentPadding:EdgeInsets.only(left: 0),
                  title:Text('Total a cobrar',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 22)) ,
                  subtitle: Text('Con efectivo'),
                  trailing: Text('0'),
                ),
                


              ],
            ),
          )
            ]
         ),
         Container(
             alignment: Alignment.bottomCenter,
             padding: EdgeInsets.only(bottom: 10),
           child: RaisedButton(                                   
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.green)
              ),
              color: Colors.green.shade500,
              padding: EdgeInsets.fromLTRB(size.width*0.2, 20.0, size.width*0.2, 20.0),
              onPressed: (){} ,
              child: Text(
                'Enviar pedido',textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.white,
                ),
              ),
            ),
         )

      
        ]
      )
     );
  } 
void _onButtonPressed(BuildContext context) {
     final size = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: size*0.75,
            child: Container(
              child: AddDireccions(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }


}


