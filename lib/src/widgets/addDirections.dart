
//packages
import 'package:flutter/material.dart';
//models
import 'package:timugo/src/models/directions_model.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
//providers
import 'package:provider/provider.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:timugo/src/widgets/formDirection.dart';

class AddDireccions extends StatefulWidget {
  
  @override
  DeleteItemInListViewPopupMenuState createState() {
    return new DeleteItemInListViewPopupMenuState();
  }
}
class DeleteItemInListViewPopupMenuState extends State<AddDireccions> {


  // finals
  final deleteDirectio = DeleteAddress();
  final prefs = new PreferenciasUsuario();
  final addressmodel =  Directions();

  var principal ='';
 

  void _addPrincipal(String value,String city){  //this function add the principal address of user
    final userInfo   = Provider.of<UserInfo>(context);
    print('estpy selecionando');
    userInfo.directions = value;
    prefs.direccion = value;
    userInfo.city= city;
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
                  _onButtonPressed(context);
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
          title: Text(producto.city+' '+producto.address),
          trailing:Icon(Icons.keyboard_arrow_left),
        
          onTap:()=> _addPrincipal(producto.address,producto.city),
      
        ),
     
      );
  }
  // show the  pop up where contains the form to add new address of user
  void _onButtonPressed(BuildContext context) { // show de modal botton sheet tha open the  add Directions widget
     final size = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: size*0.75,
            child: Container(
              child: FormDirections(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          );
        });
  }
}