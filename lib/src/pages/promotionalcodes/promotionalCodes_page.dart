//packages
import 'package:flutter/material.dart';
//models
import 'package:timugo/src/models/directions_model.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
//providers

import 'package:timugo/src/services/number_provider.dart';
import 'package:timugo/src/widgets/appbar.dart';
//import 'package:timugo/src/widgets/formDirection.dart';


class PromotionalCodes extends StatefulWidget {

  @override
  PromotionalCodesState createState() {
    return new PromotionalCodesState();
  }
}

class PromotionalCodesState extends State<PromotionalCodes> {
  // finals
  final deleteDirectio = DeleteAddress();
  final prefs = new PreferenciasUsuario();
  final addressmodel = Directions();
  //Position _currentPosition;

  var isPressed = false;
  var principal = '';
  final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>(); // global key of scaffol

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: MyAppBar(
          onPressed: (){
          Navigator.of(context).pop();
        }
        ),
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15, top: 25, right: 30),
              child: ListTile(
                title: Text("Cupones",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 33,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, top: 80, right: 30),
              alignment: Alignment.center,
              child: _createItems(),
            ),
          ],
        ));
  }

 
  // this widget call the services of get directions and  create a iterable list of istances the model Directions
  Widget _createItems() {
    final getdirections = GetAddresses();

    return FutureBuilder(
        future: getdirections.getAddresses(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Directions>> snapshot) {
          if (snapshot.hasData) {
            final productos = snapshot.data;
            return Container(
                margin: EdgeInsets.only(top: 60, bottom: 90),
                child: ListView.builder(
                    key: UniqueKey(),
                    itemCount: productos.length,
                    itemBuilder: (context, i) => ListTileItem(
          
                          producto: productos[i],
                        )
                    //{ return Card( child:_card(context, productos[i] ));}, //  create aiterable list and call _card for paint list
                    ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
// this widget paint the list of elements the address user

// show the  pop up where contains the form to add new address of user

class ListTileItem extends StatelessWidget {
  final Directions producto;
  final bool isPressed;

  ListTileItem({this.producto,this.isPressed});

  @override
  Widget build(BuildContext context) {
    final deleteDirectio = DeleteAddress();
    print(producto.favorite);
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
      child: Stack(
       children:  <Widget>[
          Row(
        children:  <Widget>[

        
        ]
      ),
      Row(
        children:  <Widget>[
        ]
      )
        ]
      ) 
    );
  }
}
