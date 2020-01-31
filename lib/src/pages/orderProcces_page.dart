import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:timugo/src/models/barbers_model.dart';
import 'package:timugo/src/models/temporalOrder_model.dart';
import 'package:timugo/src/widgets/addDirections.dart';
import 'package:timugo/src/services/number_provider.dart';



class OrderProcces extends StatefulWidget {
  @override
  _ProccesState createState() 
  {
    return new  _ProccesState();} 
}

class _ProccesState extends State<OrderProcces> {
   @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //final createOrdeProvider = CreateOrderProvider();
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
          Container(
            padding:EdgeInsets.only(left: 15,top: 80) ,
            child:Text("Orden en Curso",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold)),
          ),
          _barber(),
          Container(
            alignment: Alignment.bottomCenter,
            child:_buttonadd()
          ),
           Container(
            margin: const EdgeInsets.only(left: 20.0, right: 10.0,top: 340),
            child: Divider(
              color: Colors.black,
              height: 36,
            )),
          Container(
            padding: EdgeInsets.only(top:350),
            alignment: Alignment.bottomCenter,
            child:_crearListado()
          ),
       

          
           
        ]
      )
    );
  }
  Widget _barber(){


 final size = MediaQuery.of(context).size;
  final  temporalOrderProvider = TemporalOrderProvider();
  var barberModel = BarbersModel();
  var res = temporalOrderProvider.getBarberAsigned();
  res.then((response) async {
        if (response['response'] == 2){
           barberModel=BarbersModel.fromJson(response['content']['barber']);
           print(barberModel.birth);
        }
  });
    return Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top:120),
              child:Row(
                children: <Widget>[
                  CircleAvatar(
                    radius:75.0,
                    backgroundColor: Colors.white,
                    backgroundImage:NetworkImage(''),
                    child: CircleAvatar(
                      backgroundImage:NetworkImage(''),
                      radius:65
                    ),
                  ),
                 

                  Text('',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold )),
                  SizedBox(width: 10,),
                   SmoothStarRating(
                    allowHalfRating: false,
                    starCount: 5,
                    rating:5.0,
                    size: 25.0,
                    filledIconData: Icons.star,
                    halfFilledIconData: Icons.blur_on,
                    color: Colors.blue,
                    borderColor: Colors.blue,
                    spacing:0.0

              )
          ]
              )
            ),
            Container(
              padding: EdgeInsets.only(top: 250),
              child:ListTile(
                
                title: Text('',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                leading: IconButton(
                  icon: Icon(Icons.call,color: Colors.green,),
                  onPressed: (){},
                ),
            )
            ),

          
          ]
        );
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

       

  Widget _crearListado() {
  final  temporalOrderProvider = TemporalOrderProvider();

    
    return FutureBuilder(
     
      future: temporalOrderProvider.getTemporalProvider(),
      builder: (BuildContext context, AsyncSnapshot<List<TemporalServices>> snapshot) {
        if ( snapshot.hasData ) {

          final productos = snapshot.data;

          return ListView.builder(
            
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
                    
                      title:Text('${ producto.quantity }',style:TextStyle(fontWeight:FontWeight.w400,fontSize:18.0)) ,
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


