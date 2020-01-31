import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timugo/src/models/aditional_model.dart';
import 'package:timugo/src/models/order_model.dart';
import 'package:timugo/src/models/services_model.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:timugo/src/widgets/appbar.dart';

import 'checkout_page.dart';

class Checkin extends StatefulWidget {
  final ServicesModel model;
  Checkin({this.model});
  
  @override
  _CheckinState createState() 
  {return new  _CheckinState(model:model);} 
}

class _CheckinState extends State<Checkin> {
  final ServicesModel model;
   final List orderFinal = [];
   final List tem=[];
    final order = OrderModel();
  _CheckinState({this.model});
    

    int number = 1;
    int total = 0;
    int count =0;
    
  void addServiceToarray(){

    
    
    
    if(tem.contains(model.name)){
      for(var i in orderFinal){
        if(i["nameService"]== model.name){
          i["quantity"]=number;
        }

      }
    }else{
    tem.add(model.name);
    order.id=model.id;
    order.nameService=model.name;
    order.typeService="Service";
    order.price=model.price;
    order.quantity = number;
    orderFinal.add(order.toJson());
    }
  }

   void removeOrder(tot,key) {
    setState(() {
      if (total > 0  && tot != null) {
        total -=int.parse(tot);
        count --;
      }
      
    });
  }
  void addOrder(tot) {
    setState(() {
      if (  tot != null && count < number) {
          total += int.parse(tot);
      count ++;
        
      }

      
    });
  }

  void subtractNumbers() {
    setState(() {
      if (number > 1) {
        number --;
      }
      
    });
  }

  void addNumbers() {
    setState(() {
      number =number +1;
      
    });
  }
  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final url ='https://timugo.tk/';
  final userInfo   = Provider.of<UserInfo>(context);
  final price = int.parse(model.price);
 
  
 
 return Scaffold(
   
     
      body:Stack( 
         alignment: Alignment.topCenter,
        children:<Widget>[
          
         AppBarCheckin(),
          Positioned(

            top: 70,height: 250,
            child: Image.network(url+model.urlImg,width: 210, )
            
            //child: Image.network(url+prod.urlImg,width: 210,)
          ),
         Container(
            child:_crearListado(0),
         ),
        
          Container(
        
         alignment: Alignment.bottomCenter,
         child:SizedBox(
             width: double.infinity,
             height: 60,
             
             
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
         
            children: [
              Column(
                children: <Widget>[
                  _buttonadd()
                ],
              ),
              SizedBox(width: 50,),
               Column(
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
                userInfo.price=total.toString();
                      addServiceToarray();
                      
                     Navigator.push(
                   context,MaterialPageRoute(
                   builder: (context) => Checkout(temp:orderFinal,price:price,priceA:total)));
              },// monVal == false ? null:   _subimit ,
              child: Text(
                'Agregar'+' '+"\$"+(total+price).toString(),textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.white,
                ),
              ),
            ),
                  
                  
                ],
              )
                ],
              ),
      ),
 
          )
        
        ])
    );
  }

  Widget _buttonadd(){
   

    return Center(
      
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 
                  
                  new IconButton(
                    padding: const EdgeInsets.only(right: 40),
                    icon: Icon(Icons.remove,size: 30,),
                    color: Colors.green,
                    onPressed:subtractNumbers,
            
                  ),
                  Text(number.toString() ,style:TextStyle(fontWeight:FontWeight.w400,fontSize:30.0)),
                   new IconButton(
                    padding: const EdgeInsets.only(left: 40),
                    icon: Icon(Icons.add,size: 30,),
                    color: Colors.green,
                     onPressed:
                       addNumbers,
                       

                  ),
                ],
              )
            ],
          ),
        );


    
  }

  Widget _crearListado(double numer) {
  final  aditionalProvider = AditionalProvider();
    
    
    return Container(
      margin:  EdgeInsets.only(top: 300+numer),
      child:Stack(
        children: <Widget>[
          Container(
            margin:  EdgeInsets.only(top: 30,bottom: 100),
             
            width: double.infinity,
            color: Colors.grey[300],
            height: 50,
            child: Center(
                  child: new Text(
                  "Servicios Adicionales"+' '+number.toString(),
                  textAlign: TextAlign.center,
                  ),
                )
          ),
          
       FutureBuilder(
     
      future: aditionalProvider.getAditional(model.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List<AditionalModel>> snapshot) {
        if ( snapshot.hasData ) {

          final productos = snapshot.data;

          return ListView.builder(
            key: UniqueKey(),
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, productos[i],Key(i.toString()) ),
          );

        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
      )
        ]
      )
    );
  }

  Widget _crearItem(BuildContext context, AditionalModel producto, Key key ) {
     //final size = MediaQuery.of(context).size;

    return Container(
    
    child:Stack(
        key: key,
        children: <Widget>[
         
          
          Container(
             margin:  EdgeInsets.only(left: 20.0, right: 20.0,top: 50),
           
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('${ producto.name }',style:TextStyle(fontWeight:FontWeight.w400,fontSize:18.0)),
                      Text('+'+' '+"\$"+ '${ producto.price }',style:TextStyle(fontWeight:FontWeight.w300,fontSize:15.0)),
                    ]
                  ),
                ]
              ),
          ),
          Padding(
            
             padding: const EdgeInsets.only(left:10.0,top: 50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      color: Colors.green,
                      onPressed:(){
                        
                        removeOrder(producto.price,UniqueKey());
                        
                        deleteAditionalOrder(producto);
                      
                      
                      },
                    ),
                    Container(
                     
                      padding: const EdgeInsets.only(
                        
                        bottom: 2, right: 12, left: 12),
                      child: Text(''),
                    ),
                    IconButton(

                      key:key,
                      icon: Icon(Icons.add,size: 24,),
                      color: Colors.green,
                      onPressed: (){
                        addOrder(producto.price);
                        addAditionalOrder(producto);

                      },
                    )
                ]
            )
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 10.0,top: 70),
            child: Divider(
              color: Colors.black,
              height: 36,
            )),
          
        ]
    )
    );
   

        
      

      

    
  }
   void addAditionalOrder(producto){
      if (tem.contains(producto.name)){
         for (var i in orderFinal) {
          if (i["nameService"] == producto.name){
            i["quantity"] +=1;

          }
        }

      }
      else{

        tem.add(producto.name);
        order.id=producto.id;
        order.nameService=producto.name;
        order.typeService="aditional";
        order.price=producto.price;
        order.quantity = 1;
        orderFinal.add(order.toJson());
      }
     
     
   }

   void deleteAditionalOrder(producto){
    
      for (var i in orderFinal) {
        if (i["nameService"] == producto.name){
          if (i["quantity"] == 1){
            orderFinal.remove(i);
            tem.remove(producto.id);

          }else{
            i["quantity"] -= 1;
          }

        }
      }
   }
      
}
 

