//packages
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
//models
import 'package:timugo/src/models/directions_model.dart';
import 'package:timugo/src/pages/homeservices/services_page.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
//providers
import 'package:provider/provider.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
//import 'package:timugo/src/widgets/formDirection.dart';
import 'package:timugo/src/widgets/locations.dart';

class AddDireccions extends StatefulWidget {
  final Position position;
  AddDireccions({this.position});
  @override
  DeleteItemInListViewPopupMenuState createState() {
    return new DeleteItemInListViewPopupMenuState(position: position);
  }
}

class DeleteItemInListViewPopupMenuState extends State<AddDireccions> {
  // finals
  final Position position;
  DeleteItemInListViewPopupMenuState({this.position});
  final deleteDirectio = DeleteAddress();
  final prefs = new PreferenciasUsuario();
  final addressmodel = Directions();
  //Position _currentPosition;

  String _currentAddress;
  var isPressed = false;
  var principal = '';
  List<bool> individualCount = [false, false, false, false, false];
  final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>(); // global key of scaffol

  Future<String> _getAddressFrom() async {
    final userInfo = Provider.of<UserInfo>(context);
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          userInfo.loca.latitude, userInfo.loca.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            " ${place.name},${place.locality}, ${place.subAdministrativeArea}";
        print(_currentAddress);
      });
    } catch (e) {
      print(e);
    }
    return Future.delayed(Duration(seconds: 4), () => _currentAddress);
  }

  void addPrincipal(String value, String city, int i) {
    //this function add the principal address of user
    final userInfo = Provider.of<UserInfo>(context);
    // final addFavorite = SendFavorite();
    print('estpy selecionando');
    userInfo.directions = value;
    prefs.direccion = value;
    userInfo.city = city;
    print(prefs.direccion);
    // addFavorite.seendFavorite(value);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.red,
              size: 35,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white24,
        ),
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 15, top: 25, right: 30),
              child: ListTile(
                title: Text("Elige o agrega una dirección",
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
            Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(
                    bottom: size.height * 0.04, left: 30, right: 30),
                child: RaisedButton(
                  elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(0.0),

//
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF19AEFF),
                            Color(0xFF139DF7),
                            Color(0xFF0A83EE),
                            Color(0xFF0570E5),
                            Color(0xFF0064E0)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          size.width * 0.1,
                          size.height * 0.005,
                          size.width * 0.1,
                          size.height * 0.005),
                      child: ListTile(
                          trailing: Icon(
                            Icons.add_location,
                            color: Colors.white,
                          ),
                          title: Text("Añade una dirección ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ))),
                    ),
                  ),

                  onPressed: () {
                    _goTo();
                  },
                )),
          ],
        ));
  }

  _goTo() async {
    _getAddressFrom();
    print(_currentAddress);
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewTripLocationView()));

        //_showBottomSheetCallBack();
      });
    });
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
                          addPrincipal: () => addPrincipal(
                              productos[i].address, productos[i].city, i),
                          isPressed: individualCount[i],
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
  final Function addPrincipal;
  final bool isPressed;

  ListTileItem({this.producto, this.addPrincipal, this.isPressed});

  @override
  Widget build(BuildContext context) {
    final deleteDirectio = DeleteAddress();
    print(producto.favorite);
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.redAccent),
            onDismissed: (direccion) {
              deleteDirectio.deleteaddress(producto.address);
            },
            child: Stack(children: <Widget>[
              ListTile(
                leading: Icon(Icons.place,
                    color: producto.favorite == false
                        ? Colors.black
                        : Color(0xFF0064E0)),
                title: Text(producto.address),
                trailing: PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            deleteDirectio.deleteaddress(producto.address);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Services()));
                          }),
                    ),
                    PopupMenuItem(
                      child: IconButton(
                          icon: Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            addPrincipal();
                            Navigator.of(context).pop();
                          }),
                    ),
                  ],
                ),
                onTap: () => addPrincipal(),
              ),
            ])));
  }
}
