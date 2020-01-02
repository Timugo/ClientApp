import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timugo/src/models/aditional_model.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:timugo/src/widgets/appbar.dart';

import 'checkout_page.dart';

class Checkin extends StatefulWidget {
  
  
  @override
  _CheckinState createState() 
  {return new  _CheckinState();} 
}

class _CheckinState extends State<Checkin> {
  
  
    

    int number = 1;
    int total = 0;
    int count =0;

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
  final url ='http://167.172.216.181:3000/';
  final userInfo   = Provider.of<UserInfo>(context);
  
 
 return Scaffold(
   
     
      body:Stack( 
         alignment: Alignment.topCenter,
        children:<Widget>[
          
         AppBarCheckin(),
          Positioned(

            top: 70,height: 250,
            child: Image.network(url+userInfo.urlImg,width: 210, )
            
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

                     Navigator.push(
                   context,MaterialPageRoute(
                   builder: (context) => Checkout()));
              },// monVal == false ? null:   _subimit ,
              child: Text(
                'Agregar'+' '+"\$"+total.toString(),textAlign: TextAlign.center,
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
    
     var serv = '1';
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
     
      future: aditionalProvider.getAditional(serv),
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
       final userInfo   = Provider.of<UserInfo>(context);
     
    

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
            key: key,
             padding: const EdgeInsets.only(left:10.0,top: 50),
            child: Row(
              key: key,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                    total != 0 ?IconButton(
                      icon: Icon(Icons.remove),
                      color: Colors.green,
                      onPressed:(){removeOrder(producto.price,UniqueKey());
                      userInfo.price = total.toString();},
                    ):Container(),
                    Container(
                      
                      padding: const EdgeInsets.only(
                        bottom: 2, right: 12, left: 12),
                      child: Text(''),
                    ),
                    IconButton(
                      icon: Icon(Icons.add,size: 24,),
                      color: Colors.green,
                      onPressed: (){
                        addOrder(producto.price);
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
}
 

