
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timugo/src/models/temporalOrder_model.dart';
import 'package:timugo/src/pages/services_page.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/providers/barber_provider.dart';
import 'package:timugo/src/providers/counter_provider.dart';
import 'package:timugo/src/services/number_provider.dart';

import 'editOrder_page.dart';



class OrderProcces extends StatefulWidget {
  final int total;
  OrderProcces({this.total});
  @override
  _ProccesState createState() 
  {
    return new  _ProccesState(cant:total);} 
}

class _ProccesState extends State<OrderProcces> {
  final int cant;
  _ProccesState({this.cant});
 
  
  

  
  
  
   @override
   
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    print(cant);
     return Scaffold(
       appBar: AppBar(
         elevation: 0,
         leading: new IconButton(
               icon: new Icon(Icons.arrow_back, color: Colors.black,size: 35,),
               onPressed: () {
                Navigator.push(
                  context,  
                  MaterialPageRoute(
                    builder: (context) => Services()
                  )
                );
               },
         ),
        backgroundColor: Colors.white10,
       ),
      body:Stack( 
        children:<Widget>[
          Container(
            padding:EdgeInsets.only(left: 15,top: 10) ,
            child:Text("Orden en Curso",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold)),
          ),
           Container(
            padding:EdgeInsets.only(left: 15,top: 100) ,
            child:Text("Tu Barbero",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
          ),
          _barber(),
           
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 10),
            child:_buttonadd()
          ),
           Container(
            margin: const EdgeInsets.only(left: 20.0, right: 10.0,top: 320),
            child: Divider(
              color: Colors.black,
              height: 36,
            )),

          Container(
            padding:EdgeInsets.only(left: 15,top: 350) ,
            child:Text("Resumen de Orden",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.only(top:380,bottom: 70),
            alignment: Alignment.bottomCenter,
            child:_crearListado()
          ),

       

          
           
        ]
      )
    );
  }
  Widget _barber(){
   
    final barberAsigned   = Provider.of<BarberAsigned>(context);
     var urlI = 'https://i.pinimg.com/736x/a4/93/25/a493253f2b9b3be6ef48886bbf92af58.jpg';


     var baseUrl= 'https://www.timugo.tk/';
 //final size = MediaQuery.of(context).size;
      if (barberAsigned.name == 'Sin Asignar' ){
        _getBarber();
      }
    
    return Stack(
    
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top:120),
              child:Row(
                children: <Widget>[

                  CircleAvatar(
                    radius:75.0,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundImage:NetworkImage( barberAsigned.urlImg ==''? urlI:baseUrl+barberAsigned.urlImg ),
                      radius:65
                    ),
                  ),
                 

                  Text(barberAsigned.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold )),
                  SizedBox(width: 10,),
               
          ]
              )
            ),
            Container(
              padding: EdgeInsets.only(top: 250),
              child:ListTile(
                
                title: Text(barberAsigned.phone,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                leading: IconButton(
                  icon: Icon(Icons.call,color: Colors.green,),
                  onPressed: (){
                    
                  },
                ),
            )
            ),

          
          ]
        );
  }

  void _getBarber(){
    final barberAsigned   = Provider.of<BarberAsigned>(context);
    final  temporalOrderProvider = TemporalOrderProvider();
    final prefs = PreferenciasUsuario();
    var res = temporalOrderProvider.getBarberAsigned();
   
    res.then((response) async {
          if (response['response'] == 2  && response['content']['barber']['name'] !='Sin'){
            print(response['content']['barber']);
            barberAsigned.name=(response['content']['barber']['name']);
            barberAsigned.stairs=(response['content']['barber']['stairs'])*1.0;
            barberAsigned.urlImg=(response['content']['barber']['urlImg']);
            barberAsigned.phone=(response['content']['barber']['phone']).toString();
           
            
          }else{
            if (response['response'] == 1){
              prefs.order = '0';
               
            }
          }
    });
    

  }
   Widget _buttonadd(){
   final size = MediaQuery.of(context).size;

    return Container(
        
          
             child: new Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 
                  RaisedButton(                                   
                      elevation: 5.0,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.green)
                      ),
                      color: Colors.green.shade400,
                      padding: EdgeInsets.fromLTRB(size.width*0.1, 20.0, size.width*0.1, 20.0),
                      onPressed:(){
                          _onButtonPressed(context);
                      },// monVal == false ? null:   _subimit ,
                      child: Text(
                        'Editar Orden',textAlign: TextAlign.center,
                        style: TextStyle(
                        color: Colors.white,
                        ),
                      ),
            ),
                    
              RaisedButton(                                   
                      elevation: 5.0,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.red)
                      ),
                      color: Colors.red.shade400,
                      padding: EdgeInsets.fromLTRB(size.width*0.1, 20.0, size.width*0.1, 20.0),
                      onPressed:(){
                        _subimit(context);
                      },// monVal == false ? null:   _subimit ,
                      child: Text(
                        'Cancelar Orden',textAlign: TextAlign.center,
                        style: TextStyle(
                        color: Colors.white,
                        ),
                      ),
            ),
               
                ],
              )
          
        );


    
  }

 _subimit(context) {
    Alert(
      context: context,
      title: "CONFIRMACIÓN",
      desc: "Estás  seguro de cancelar tu Orden?",
      buttons: [
        DialogButton(
          child: Text(
            "ACEPTAR",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed:(){
             final finishOrder =  FinishOrderProvider();
              var res = finishOrder.finishOrder();
              res.then((response) async {
          if (response['response'] == 2){
             Navigator.push(
                  context,  
                  MaterialPageRoute(
                    builder: (context) => Services()
                  )
                );

              }
          });
   
          },
          color: Colors.green,
        ),
        DialogButton(
          child: Text(
            "CANCELAR",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
         color:  Colors.red,
        )
      ],
    ).show();
  }

  Widget _crearListado() {
  final  temporalOrderProvider = TemporalOrderProvider();

    
    return FutureBuilder(
     
      future: temporalOrderProvider.getTemporalProvider(),
      builder: (BuildContext context, AsyncSnapshot<List<TemporalServices>> snapshot) {
        if ( snapshot.hasData ) {

          final productos = snapshot.data;

          return ListView.builder(
            scrollDirection: Axis.vertical,
            key: UniqueKey(),

            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, productos[i] ),
          );

        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
      );
  }
  

  Widget _crearItem(BuildContext context, TemporalServices producto ) {
     //final size = MediaQuery.of(context).size;

    return Container(
      
    
    child:Stack(
        
        children: <Widget>[
          Container(
             margin:  EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    
                      title:Text('x'+' '+'${ producto.quantity }',style:TextStyle(fontWeight:FontWeight.w400,fontSize:18.0)) ,
                      leading:Text('${ producto.nameService }',style:TextStyle(fontWeight:FontWeight.w400,fontSize:18.0)),
                      trailing:Text("\$"+'${ producto.price }',style:TextStyle(fontWeight:FontWeight.w300,fontSize:15.0)),
                  ),
                   Container(
                    margin: const EdgeInsets.only(),
                    child: Divider(
                      color: Colors.black,
                      height: 36,
            )),

                ]
              ),
          ),
          
        ]
    )
    );
   

        
      

      

    
  } 
void _onButtonPressed(BuildContext context) {
     final size = MediaQuery.of(context).size.height;
     final totalA   = Provider.of<Counter>(context);
     
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: size*0.75,
            child: Container(
              child:EditOrder(total:cant == null ?totalA.tot :cant),
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


