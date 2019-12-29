import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timugo/src/providers/user.dart';

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
  @override
  Widget build(BuildContext context) {
     final userInfo   = Provider.of<UserInfo>(context);
      print(userInfo.directions);
      List<String> _datas=userInfo.directions ;


      _onSelected(dynamic val) {
        setState(() => _datas.removeWhere((data) => data == val));
      }

    return Scaffold(
     
      body:Stack(
      
      children:<Widget>[

       Container(
         padding:EdgeInsets.only(left: 15,top: 25) ,
        child:Text("Elige una dirección",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold)),
       ),
      
     
       
       
      ListView(
        padding: EdgeInsets.only(top:80),
        children: _datas
            .map((data) => ListTile(
                  title: Text(data),
                  trailing: PopupMenuButton(
                    onSelected: _onSelected,
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            value: data,
                            child: Text("Eliminar"),
                          ),
                        ],
                  ),
                ))
            .toList(),

     
       ),

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


  void _subimit(BuildContext context){
   final userInfo   = Provider.of<UserInfo>(context);  
    List<String> _datas= userInfo.directions;

  
   
   Alert(
        context: context,
        title: "Añade Dirección",
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.location_city),
                labelText: 'Ciudad',
                
              ),
              controller: cityController,
              


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
            
              
              _datas.add(cityController.text+directionController.text);
              userInfo.directions= _datas;
              Navigator.pop(context);
              },
            child: Text(
              "Añadir",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
 }
    }