import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timugo/src/models/directions_model.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';

class AddDireccions extends StatefulWidget {
  
  @override
  DeleteItemInListViewPopupMenuState createState() {
    return new DeleteItemInListViewPopupMenuState();
  }
}
class DeleteItemInListViewPopupMenuState
    extends State<AddDireccions> {     
      TextEditingController cityController = new TextEditingController();
      TextEditingController directionController = new TextEditingController();
    final deleteDirectio = DeleteAddress();
  _onSelected(dynamic val) {
    deleteDirectio.deleteaddress(val);
    
       
      }

  @override
  Widget build(BuildContext context) {
    
    
      
     


      
    return Scaffold(
     
      body:Stack(
      
      children:<Widget>[

       Container(
         padding:EdgeInsets.only(left: 15,top: 25) ,
        child:Text("Elige una dirección",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold)),
       ),
      
     
       
       
      _createItems(),
         Container(
        
         alignment: Alignment.bottomLeft,
         child:SizedBox(
             width: double.infinity,
             
             
         child:RaisedButton.icon(
           
            color: Colors.white,
            icon:Icon(Icons.add_location),
            label:Text("Ingresa una dirección ",style: TextStyle(color: Colors.black38,fontSize: 20)),
            onPressed: (){_subimit(context);

            },



         )
         )
        
       ),
      ],
      )
    );
  }
  Widget _createItems(){
     final getdirections =GetAddresses();
      final size = MediaQuery.of(context).size;
     return FutureBuilder(
      future:  getdirections.getAddresses(),
      builder: (BuildContext context, AsyncSnapshot<List<Directions>> snapshot) {  
        if ( snapshot.hasData ) {
          final productos = snapshot.data;
          return Container(
            margin:  EdgeInsets.only(top: 60,bottom: 50),
            child:ListView.builder(
        
            key: UniqueKey(),
            itemCount: productos.length,
            itemBuilder: (context, i) => _card(context, productos[i] ),
            )
          );

        }else{
          return Center( child: CircularProgressIndicator());
        }
       }
    );


  }
  Widget _card(  context,Directions producto){
      
        return Stack(
          children: <Widget>[
          ListTile(
          leading: Text(producto.city),
          subtitle: Text(''),
          title: Text(producto.address),
          trailing: PopupMenuButton(
            onSelected:_onSelected
            ,
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
                  PopupMenuItem(
                    value: producto.address,
                    child: Text("Eliminar"),
                  ),
                ],
          ),
                ),
                 Container(
            margin: const EdgeInsets.only(left: 20.0, right: 10.0,top: 70),
            child: Divider(
              color: Colors.black,
              height: 1,
            )),
          ]
        );


  }


  void _subimit(BuildContext context){
   final userInfo   = Provider.of<UserInfo>(context);
  
   final sendDirection = DirectionProvider();
   final prefs = new PreferenciasUsuario();
    var _value;  
    List<String> _datas= userInfo.directions;

  
   
   Alert(
        context: context,
        title: "Añade Dirección",
        content: Column(
          children: <Widget>[
           
             DropdownButton<String>(
              items: [
                DropdownMenuItem<String>(
                  child: Text('Cali'),
                  value: 'Cali',
                ),
                DropdownMenuItem<String>(
                  child: Text('Palmira'),
                  value: 'Palmira',
                ),
                DropdownMenuItem<String>(
                  child: Text('Jamundi'),
                  value: 'Jamundi',
                ),
              ],
              onChanged: (String value) {
                setState(() {
                  _value = value;
                });
          },
             
              


            ),
            TextField(
              
              
              decoration: InputDecoration(
                icon: Icon(Icons.directions),
                labelText: 'Dirección',
              ),
              controller:directionController ,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
            
              
              _datas.add(_value+' '+directionController.text);
              userInfo.directions= _datas;
              
              var res= sendDirection.sendDirection(int.parse(prefs.token),_value,directionController.text);
               res.then((response) async {
                 print(response);
                if (response['response'] == 2){
                  
                  Navigator.pop(context);
                }
               });
            },
            
            child: Text(
              "Añadir",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
 }
    }