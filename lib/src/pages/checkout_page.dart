//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timugo/src/providers/user.dart';
//pages
import 'package:timugo/src/widgets/addDirections.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'orderProcces_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

//this class contains the user order summary
class Checkout extends StatefulWidget {
    final List temp;
    final int price;
    final int priceA;
  Checkout({this.temp,this.price,this.priceA});

  @override
  _CheckoutState createState() 
  {return new  _CheckoutState(temp:temp,priceA:priceA,price:price);} 
}

class _CheckoutState extends State<Checkout> {
     final List temp;
     final int price;
     final int  priceA;
  _CheckoutState({this.temp,this.price,this.priceA});

   @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final createOrdeProvider = CreateOrderProvider();
    final prefs = new PreferenciasUsuario();  
    final userInfo   = Provider.of<UserInfo>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black,size: 35,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      backgroundColor: Colors.white10,
       ),
      body:Stack( 
        children:<Widget>[
          ListView(
            children:<Widget>[
              Container(
                padding:EdgeInsets.only(left: size.width*0.05,top: size.height*0.05,bottom:size.height*0.05) ,
                child:Text("Resumen de Orden",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold)),
              ),
              Card(
                child:ListTile(
                  title: Text(prefs.direccion == ''?'Elige una dirección':userInfo.directions),
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
              SizedBox(height: size.height*0.05,),
              Container(
                padding:EdgeInsets.only(left: size.width*0.05,right: size.width*0.05,bottom: size.height*0.1 ) ,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Resumen',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 22)),
                    ListTile(
                      contentPadding:EdgeInsets.only(left: 0),
                      title: Text('Costo del servicio :'),
                      trailing: Text(price.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                    ),
                  
                    ListTile(
                      contentPadding:EdgeInsets.only(left: 0),
                      title:Text('Costos adiccionales :') ,
                      trailing: Text(priceA.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                    ),
                    
                      ListTile(
                      contentPadding:EdgeInsets.only(left: 0),
                      title:Text('Total a cobrar',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 22)) ,
                      subtitle: Text('Con efectivo'),
                      trailing: Text((price+priceA).toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                    ),
                  ],
                ),
              )
            ]
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: size.height*0.01),
            child: RaisedButton(                                   
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.green)
              ),
              color: Colors.green.shade500,
              padding: EdgeInsets.fromLTRB(size.width*0.3, size.height*0.020, size.width*0.3, size.height*0.020),
              onPressed: (){
                var res= createOrdeProvider.createOrder(int.parse(prefs.id),prefs.direccion,userInfo.city,temp);
               if( prefs.direccion != ''){
                res.then((response) async {
                  if (response['response'] == 2){
                    if (response['content']['code'] == 1){
                         _showMessa( "Horario de servicio de 10 a.m - 8 p.m! ");

                    }else{
                    Navigator.push(
                      context,  
                        MaterialPageRoute(
                          builder: (context) => OrderProcces()
                        ));
                    }
                  }
                });
              }else{
                _showMessa( "Por favor  elige una direccion!");
              }
              
              } ,
              child: Text('Enviar pedido'+' '+"\$"+(price+priceA).toString(),textAlign: TextAlign.center, style: TextStyle(color: Colors.white, ),
              ),
            ),
         )
        ]
      )
    );
  } 
  _showMessa(String msj){ // show the toast message in bell appbar
    Fluttertoast.showToast(
      msg:msj,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0
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
      }
    );
  }


}


