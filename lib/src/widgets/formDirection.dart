import 'package:flutter/material.dart';
import 'package:timugo/src/pages/services_page.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/services/number_provider.dart';

class FormDirections extends StatefulWidget {
  @override
  _FormDirectionsState createState() => _FormDirectionsState();
}

class _FormDirectionsState extends State<FormDirections> {
    // controllers of form add address
  TextEditingController cityController = new TextEditingController();
  TextEditingController directionController = new TextEditingController();
  final sendDirection = DirectionProvider();
  final prefs = new PreferenciasUsuario();
  
  var _currencies = ['Cali','Palmira','Jamundi'];  // list of  cities aprove
  List<String> _datas= []; 
   // temporal list to add  data of form 
  var _value = 'Cali';

   void  _citySelected(String value){ // this function change de city selected in the form
    _value= value; 
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black,size: 35,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      backgroundColor: Colors.white10,
       ),
      body: ListView(
        
        children:<Widget>[
          Container(
          padding:EdgeInsets.only(left:size.width*0.04) ,
          child:Text("Añade una Dirección",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold)),
         ),
         Container(
          
          padding:EdgeInsets.only(left: size.width*0.04,top: 20,right: size.width*0.04) ,
           child:Column(
             
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
          )
         ),
           Container(
            margin: EdgeInsets.only(top: 120),
            alignment: Alignment.bottomCenter,
            child:RaisedButton(                                   
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.green)
              ),
              color: Colors.green.shade400,
              padding: EdgeInsets.fromLTRB(size.width*0.2, size.height*0.02, size.width*0.2,size.height*0.02),
              onPressed: () { // when  pressed  call service sen Direction and add address of user
                _datas.add(_value+' '+directionController.text);
                var res= sendDirection.sendDirection(int.parse(prefs.token),_value,directionController.text);
                res.then((response) async {
                  if (response['response'] == 2){
                    Navigator.pop(context);
                    Navigator.push(
                      context,MaterialPageRoute(
                      builder: (context) => Services()));
                  }
                });
              },
              child: Text('Agregar',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,)),
            ),
           )
        ]
    
    )
    );
  }
 
}

