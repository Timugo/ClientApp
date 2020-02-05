
//packages
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
//models
import 'package:timugo/src/models/directions_model.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
//providers
import 'package:provider/provider.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';

class AddDireccions extends StatefulWidget {
  
  @override
  DeleteItemInListViewPopupMenuState createState() {
    return new DeleteItemInListViewPopupMenuState();
  }
}
class DeleteItemInListViewPopupMenuState extends State<AddDireccions> {

  // controllers of form add address
  TextEditingController cityController = new TextEditingController();
  TextEditingController directionController = new TextEditingController();
  // finals
  final deleteDirectio = DeleteAddress();
  final prefs = new PreferenciasUsuario();
  final addressmodel =  Directions();
  var _value = 'Cali';
  var principal ='';
    
    


  void  _citySelected(String value){ // this function change de city selected in the form
    
    _value= value; 
  }

  _addPrincipal(String value){  //this function add the principal address of user
    final userInfo   = Provider.of<UserInfo>(context);
    userInfo.directions = value;
    prefs.direccion = value;
    userInfo.city= value;
    print(prefs.direccion );
      
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
                onPressed: (){
                  _subimit(context);
                },
              )
            )
          ),
        ],
      )
    );
  }
  // this widget call the services of get directions and  create a iterable list of istances the model Directions
  Widget _createItems(){
     final getdirections =GetAddresses();

     return FutureBuilder(
      future:  getdirections.getAddresses(),
      builder: (BuildContext context, AsyncSnapshot<List<Directions>> snapshot) {  
        if( snapshot.hasData ){
          final productos = snapshot.data;
          return Container(
            margin:  EdgeInsets.only(top: 60,bottom: 50),
            child:ListView.builder(
              key: UniqueKey(),
              itemCount: productos.length,
              itemBuilder: (context, i) => _card(context, productos[i] ), //  create aiterable list and call _card for paint list
            )
          );
        }else{
          return Center(
            child: CircularProgressIndicator()
          );
        }
      }
    );
  }
  // this widget paint the list of elements the address user
  Widget _card(  context,Directions producto){
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color:Colors.redAccent
        ),
         onDismissed: (direccion){
          deleteDirectio.deleteaddress(producto.address);
        },
        child: ListTile(
          leading: Text(producto.city),
          title: Text(producto.address),
          trailing: PopupMenuButton(
            onSelected:_addPrincipal ,  //  change the principal address of user
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: (producto.address),
                child: Text("Seleccionar"),
              ),
            ],
          ),
        ),
     
      );
  }
  // show the  pop up where contains the form to add new address of user
  void _subimit(BuildContext context){

    final sendDirection = DirectionProvider();
    final prefs = new PreferenciasUsuario();
    var _currencies = ['Cali','Palmira','Jamundi'];  // list of  cities aprove
    List<String> _datas= [];  // temporal list to add  data of form 
    Alert(
        context: context,
        title: "Añade Dirección",
        content: Column(
          children: <Widget>[
            DropdownButton<String>(
              items: _currencies.map((String dropDownStringItem){ // this function paint the cities as  dropDownStrings
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
              }).toList(),
              onChanged: (String value) {
                _citySelected(value);
              },
              value: _value,
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
            onPressed: () { // when  pressed  call service sen Direction and add address of user
              _datas.add(_value+' '+directionController.text);
              var res= sendDirection.sendDirection(int.parse(prefs.token),_value,directionController.text);
              res.then((response) async {
                 if (response['response'] == 2){
                   Navigator.pop(context);
                }
              });
            },
            child: Text( "Añadir",style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}