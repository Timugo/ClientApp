
//packages
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
// pages
import 'package:timugo/src/widgets/appbar.dart';
import 'checkout_page.dart';
//providers
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
//models
import 'package:timugo/src/models/aditional_model.dart';
import 'package:timugo/src/models/order_model.dart';
import 'package:timugo/src/models/services_model.dart';



  // this class contains the  checkin and  aditional services of  services pages
class Checkin extends StatefulWidget {
  final ServicesModel model;  //  this class receive  the model of services 
  Checkin({this.model});
  
  @override
  _CheckinState createState() {
    return new  _CheckinState(model:model);
  } 
}

class _CheckinState extends State<Checkin> {

  final ServicesModel model;
  _CheckinState({this.model});


  final List orderFinal = [];
  final List tem=[];
  final order = OrderModel();
  
  int number = 1;
  int total = 0;
  int count =0;

  // this function add the  principal service of user
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
  // this function  decrease the  number of people that give the pricipal service
  void removeOrder(tot,key) {
    setState(() {
      if (total > 0  && tot != null) {
        total -=int.parse(tot);
        count --;
      }
    });
  }
  // this function increase the  number of people that give the pricipal service
  void addOrder(tot) {
    setState(() {
      if (  tot != null && count < number) {
          total += int.parse(tot);
      count ++;
      }
    });
  }
 // this function  decrease the  number of  aditionals items  that has the pricipal service
  void subtractNumbers() {
    setState(() {
      if (number > 1) {
        number --;
      }
      
    });
  }
 // this function  increase the  number of  aditionals items  that has the pricipal service

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
          top: 70,height: size.height*0.25,
          child: Image.network(url+model.urlImg,width:  size.height*0.20, )
        ),
        Container(
          child:_crearListado(),
        ),
        Container(
        
          alignment: Alignment.bottomCenter,
          child:SizedBox(
            width: double.infinity,
            height: size.height*0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: <Widget>[
                    _buttonadd()
                  ],
                ),
                SizedBox(width: size.width*0.07,),
                Column(
                  children: <Widget>[
                    RaisedButton(                                   
                      elevation: 5.0,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.green)
                      ),
                      color: Colors.green.shade400,
                      padding: EdgeInsets.fromLTRB(size.width*0.1, size.height*0.02, size.width*0.1,size.height*0.02),
                      onPressed:(){
                        userInfo.price=total.toString();
                        addServiceToarray();
                        Navigator.push(
                          context,MaterialPageRoute(
                          builder: (context) => Checkout(temp:orderFinal,price:price*number,priceA:total)));
                      },// monVal == false ? null:   _subimit ,
                      child: Text('Agregar'+' '+"\$"+(total+price*(number)).toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,)),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ]
    )
    );
  }
// this  widget contains the add button
  Widget _buttonadd(){
    final size = MediaQuery.of(context).size;

     return Center(
       child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new IconButton(
                padding:  EdgeInsets.only(right: size.width*0.04),
                icon: Icon(Icons.remove,size: 30,),
                color: Colors.green,
                onPressed:subtractNumbers,
              ),
              Text(number.toString() ,style:TextStyle(fontWeight:FontWeight.w400,fontSize:30.0)),
              new IconButton(
                padding: EdgeInsets.only(left: size.width*0.04),
                icon: Icon(Icons.add,size: 30,),
                color: Colors.green,
                onPressed: addNumbers,
              ),
            ],
          )
        ],
      ),
    );
  }
  //this widget paint  call the aditional services provider and create a iterable list
  Widget _crearListado() {
    final  aditionalProvider = AditionalProvider();
    final size = MediaQuery.of(context).size;

    return Container(
      margin:  EdgeInsets.only(top: size.height*0.35),
      child:Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: Colors.grey[300],
            height: size.height*0.05,
            child:Center(
                  child: new Text("Servicios Adicionales"+' '+number.toString(),textAlign: TextAlign.center,),
            )
          ),
          Container(
             margin:  EdgeInsets.only(top: size.height*0.05,bottom:size.height*0.1),
            child:FutureBuilder(
              future: aditionalProvider.getAditional(model.id.toString()),
              builder: (BuildContext context, AsyncSnapshot<List<AditionalModel>> snapshot) {
                if ( snapshot.hasData ) {
                  final productos = snapshot.data;
                  return ListView.builder(
                    key: UniqueKey(),
                    
                    itemCount: productos.length,
                    itemBuilder: (context, i) => _crearItem(context, productos[i],Key(i.toString()) ),
                  );
                }else {
                  return Center( child: CircularProgressIndicator());
                }
              },
            )
         )
        ]
      )
    );
  }

  Widget _crearItem(BuildContext context, AditionalModel producto, Key key ) {
     final size = MediaQuery.of(context).size;
    return Container(
       margin:  EdgeInsets.only(left: size.width*0.04, right:size.width*0.04),
      child:Stack(
        key: key,
        children: <Widget>[
          Container(
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
            padding:EdgeInsets.only(),
            child:Row(
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
            margin:  EdgeInsets.only(left:size.width*0.02, right: size.width*0.02,top: size.width*0.1),
            child: Divider(
              color: Colors.black,
              height: 36,
            )
          ),
        ]
      )
    );
  }
  // this function add the  items the order to list as  json 
  void addAditionalOrder(producto){

    if (tem.contains(producto.name)){ //verify that the article is already added to the list
      for (var i in orderFinal) {
        if (i["nameService"] == producto.name){
          if( i["quantity"] < number){
              i["quantity"] +=1;
          }
           // just add if it's on the list
        }
      }
    }
    else{  //if not added create the item
      tem.add(producto.name);
      order.id=producto.id;
      order.nameService=producto.name;
      order.typeService="aditional";
      order.price=producto.price;
      order.quantity = 1;
      orderFinal.add(order.toJson());
    }
  }
  // this function delete the  items the order to list as  json 
  void deleteAditionalOrder(producto){

    for (var i in orderFinal) {
      if (i["nameService"] == producto.name){
        if (i["quantity"] == 1){  // if  te quantity of item is the  latest  the delte of list 
          orderFinal.remove(i);
          tem.remove(producto.id);
        }else{
          i["quantity"] -= 1; // just drecrement if there is more than one item
        }
      }
    }
  }
      
}
 

