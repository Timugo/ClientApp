
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timugo/src/models/order_model.dart';
import 'package:timugo/src/models/temporalOrder_model.dart';
import 'package:timugo/src/pages/orderProcces_page.dart';
import 'package:timugo/src/providers/counter_provider.dart';
import 'package:timugo/src/services/number_provider.dart';



class EditOrder extends StatefulWidget {
   final int total;
  EditOrder({this.total});
  @override
  _EditOrderState createState() 
  {
    return new  _EditOrderState(cant:total);} 
}

class _EditOrderState extends State<EditOrder> {
  final int cant;
  final List tem=[];
  final order = OrderModel();
  final List orderFinal = [];
  
  _EditOrderState({this.cant});
  int preTotal =0;
  int  total = 0;
  int count = 1;
 
    void removeOrder(tot,key) {
    setState(() {
      if (total > 0 ) {
        total -=tot;
        count --;
      }
      
    });
  }
  void addOrder(tot) {
    setState(() {
      
          total +=tot;
      count ++;
        
      

      
    });
  }
  

  
  
  
   @override
   
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    print(cant);
     return Scaffold(
      body:Stack( 
        children:<Widget>[
          
          
          
           
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 10),
            child:_buttonadd()
          ),
         
          Container(
            padding: EdgeInsets.only(top:10,bottom: 70),
            alignment: Alignment.bottomCenter,
            child:_createEdit()
          ),

       

          
           
        ]
      )
    );
  }
 

   Widget _buttonadd(){
   final size = MediaQuery.of(context).size;
  print(orderFinal);
    return Container(
    
          
             child: 
                 
                 RaisedButton(                                   
                elevation: 5.0,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.green)
                ),
                color: Colors.green.shade400,
                padding: EdgeInsets.fromLTRB(size.width*0.3, 20.0, size.width*0.3, 20.0),
                onPressed:(){
                    _subimit(context);
                },// monVal == false ? null:   _subimit ,
                child: Text(
                  'Enviar Orden'+' '+"\$"+(total+cant).toString(),textAlign: TextAlign.center,
                  style: TextStyle(
                  color: Colors.white,
                        ),
                )
        
              )
          
        );


    
  }
  
 _subimit(context) {
   final totalA   = Provider.of<Counter>(context);
    Alert(
      context: context,
      title: "CONFIRMACIÓN",
      desc: "Estás  seguro de editar tu Orden?",
      buttons: [
        DialogButton(
          child: Text(
            "ACEPTAR",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed:(){
             final editOrderProvider =   EditOrderProvider();
              var res = editOrderProvider.editOrderProvider(orderFinal);
              res.then((response) async {
          if (response['response'] == 2){
            totalA.tot=preTotal;
            Navigator.push(
                  context,  
                  MaterialPageRoute(
                    builder: (context) => OrderProcces()
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

 
  
  Widget _createEdit() {
  final  temporalOrderProvider = TemporalOrderProvider();
  

 // final size = MediaQuery.of(context).size;

    
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 20 ),
          child: Text('Editar Orden Actual',style:TextStyle(fontWeight:FontWeight.bold,fontSize:18.0)),
        ),
      FutureBuilder(
     
      future: temporalOrderProvider.getTemporalProvider(),
      builder: (BuildContext context, AsyncSnapshot<List<TemporalServices>> snapshot) {
        if ( snapshot.hasData ) {

          final productos = snapshot.data;

          return ListView.builder(
            padding: EdgeInsets.only(top: 40),
            scrollDirection: Axis.vertical,
            key: UniqueKey(),

            itemCount: productos.length,
            itemBuilder: (context, i) => _editItem(context, productos[i],Key(i.toString()) ),
          );

        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
      ),
      ]
    );
  }
  

  Widget _editItem(BuildContext context, TemporalServices producto, Key key ) {
     //final size = MediaQuery.of(context).size;
  
     return Container(
       key: key,
      child:Stack(
       
        children: <Widget>[
         
          
          Container(
             margin:  EdgeInsets.only(left: 20.0, right: 20.0,top: 50),
           
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('${ producto.nameService }',style:TextStyle(fontWeight:FontWeight.w400,fontSize:18.0)),
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
                       
                        
                  //      deleteAditionalOrder(producto);
                      
                      
                      },
                    ),
                    Container(
                     
                      padding: const EdgeInsets.only(
                        
                        bottom: 2, right: 12, left: 12),
                      child: Text( '' ),
                    ),
                    IconButton(

                      key: key,
                      icon: Icon(Icons.add,size: 24,),
                      color: Colors.green,
                      onPressed: ()  {
                        addOrder(producto.price);
                        addAditionalOrder(producto);
                      }
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
      if (tem.contains(producto.nameService)){
         for (var i in orderFinal) {
          if (i["nameService"] == producto.nameService){
            i["quantity"] +=1;
            preTotal += producto.price;
          }
        }

      }
      else{

        tem.add(producto.nameService);
        order.id=producto.id;
        order.nameService=producto.nameService;
        order.typeService="aditional";
        order.price=producto.price.toString();
        order.quantity = producto.quantity+1;
        orderFinal.add(order.toJson());
        preTotal+=int.parse(order.price)*order.quantity;
      }
     
     
   }

   void deleteAditionalOrder(producto){
    
      for (var i in orderFinal) {
        if (i["nameService"] == producto.nameService){
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


