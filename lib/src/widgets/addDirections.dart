
//packages
import 'package:flutter/material.dart';
//models
import 'package:timugo/src/models/directions_model.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
//providers
import 'package:provider/provider.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
//import 'package:timugo/src/widgets/formDirection.dart';
import 'package:timugo/src/widgets/locations.dart';

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
  var isPressed = false;
  var principal ='';
  List<bool> individualCount = [false,false,false,false,false];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>(); // global key of scaffol
  VoidCallback _showBottomSheetCallBack;
  @override
  void initState() {
    super.initState();
    _showBottomSheetCallBack = _onButtonPressed;
  }
   void _onButtonPressed() {
     setState(() {
       _showBottomSheetCallBack = null; 
     }); // show de modal botton sheet tha open the  add Directions widget
    
    _scaffoldKey.currentState.showBottomSheet( (context) {
          return Container(
            color: Color(0xFF737373),
           
            child: Container(
              child: NewTripLocationView(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          );
        })
        .closed
        .whenComplete((){
          if(mounted){
            setState((){
            _showBottomSheetCallBack = _onButtonPressed;
            });
          }
        });
  }
 

  void addPrincipal(String value,String city,int i){  //this function add the principal address of user
    final userInfo   = Provider.of<UserInfo>(context);
    print('estpy selecionando');
    userInfo.directions = value;
    prefs.direccion = value;
    userInfo.city= city;
    print(prefs.direccion );
     {
      setState(()
      {
        individualCount[i]=true;
      });                    
    }
  

  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     key: _scaffoldKey,
       resizeToAvoidBottomInset: true,
      body:Stack(
        children:<Widget>[
          Container(
          padding:EdgeInsets.only(left: 15,top: 25) ,
          child:Text("Elige una dirección",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold)),
        ),
        Container(
           padding:EdgeInsets.only(left:15,top: 80),
          alignment: Alignment.center,
          child: _createItems(),

        ),
       
          Container(
          
            alignment: Alignment.bottomLeft,
            child:SizedBox(
              width: double.infinity,
              child:RaisedButton.icon(
                color: Colors.white,
                icon:Icon(Icons.add_location),
                label:Text("Ingresa una dirección ",style: TextStyle(color: Colors.black38,fontSize: 20)),
                onPressed: (){
                  _showBottomSheetCallBack();
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
              itemBuilder: (context, i) => ListTileItem(
               addPrincipal: () => addPrincipal(productos[i].address,productos[i].city,i),
               isPressed: individualCount[i],
               producto: productos[i],

            


              )
              //{ return Card( child:_card(context, productos[i] ));}, //  create aiterable list and call _card for paint list
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
  Widget _card(  context,Directions producto,i){
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color:Colors.redAccent
        ),
         onDismissed: (direccion){
          deleteDirectio.deleteaddress(producto.address);
        },
        child: Stack(
        children: <Widget>[
         
          ListTile(
          leading: Icon(Icons.add_location),
          title: Text(producto.city+' '+producto.address),
          trailing:PopupMenuButton<int>(
          itemBuilder: (context) => [
                PopupMenuItem(
                  child: IconButton(
                  icon:Icon( Icons.delete,color: Colors.red,),
                  onPressed:() => _createItems()),
                ),
                 PopupMenuItem(
                  child: IconButton(
                  icon:Icon( Icons.check,color: Colors.green,),
                  onPressed:()=> addPrincipal(producto.address,producto.city,i)),
                ),
              ],
        ),

        
          onTap:()=> addPrincipal(producto.address,producto.city,i),
      
        ),
         
       
     
        ]));
  }
  // show the  pop up where contains the form to add new address of user
  
}

class ListTileItem extends StatelessWidget {
  final Directions producto;
  final Function addPrincipal;
  final bool isPressed;

  ListTileItem({this.producto,this.addPrincipal,this.isPressed});

  @override
  Widget build(BuildContext context) {
    final deleteDirectio = DeleteAddress();
     return Card(
       child:Dismissible(
        key: UniqueKey(),
        background: Container(
          color:Colors.redAccent
        ),
         onDismissed: (direccion){
          deleteDirectio.deleteaddress(producto.address);
        },
        child: Stack(
        children: <Widget>[
         
          ListTile(
          leading: Icon(Icons.add_location,color:(isPressed) ? Color(0xff007397)
                        : Color(0xff9A9A9A)),
          title: Text(producto.address),
          trailing:PopupMenuButton<int>(
          itemBuilder: (context) => [
                PopupMenuItem(
                  child: IconButton(
                  icon:Icon( Icons.delete,color: Colors.red,),
                  onPressed:() {}),
                ),
                 PopupMenuItem(
                  child: IconButton(
                  icon:Icon( Icons.check,color: Colors.green,),
                  onPressed:()=> addPrincipal()),
                ),
              ],
        ),

        
          onTap:()=> addPrincipal(),
      
        ),
         
       
     
        ])));
  
  }
}