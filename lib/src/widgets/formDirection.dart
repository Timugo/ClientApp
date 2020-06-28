import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timugo/src/pages/services_page.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'noLocation.dart';
class FormDirections extends StatefulWidget {
  final String address;
  final Position position;

  FormDirections({this.address,this.position});
  @override
  _FormDirectionsState createState() => _FormDirectionsState(address: address,position: position);
}

class _FormDirectionsState extends State<FormDirections> {
  // controllers of form add address
  TextEditingController cityController = new TextEditingController();
  TextEditingController directionController = new TextEditingController();
  TextEditingController aditionalController = new TextEditingController();

  final String address;
  final Position position;
 
  double latitude;
  double longitude;
  GoogleMapController _controller;

  _FormDirectionsState({this.address,this.position});
  
  final sendDirection = DirectionProvider();
  final prefs = new PreferenciasUsuario();
  
  List<String> _datas= []; 
  List<Marker> allMarkers = [];
   // temporal list to add  data of form 
  var _value = 'Cali';
  Future<double> _getAddressFromLatLng(String address) async {

    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    try {
      List<Placemark> placemark = await geolocator.placemarkFromAddress(address);
      Placemark place = placemark[0];
      setState(() {
        latitude=place.position.latitude;
        longitude=place.position.longitude;
      });
    } catch (e) {
      print(e);
    }
    return longitude;
  }
  @override
  void initState() {
    super.initState();
    allMarkers.add(
      Marker(
        consumeTapEvents: true,
        markerId: MarkerId('marker_2'),
        onTap: () {
          print(LatLng);
        },
        draggable: true,
        position: LatLng(position.latitude, position.longitude),
        onDragEnd: ((value) {
            print(value.latitude);
            print(value.longitude);
        }),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final userInfo   = Provider.of<UserInfo>(context);
    directionController.text  = address;
    _getAddressFromLatLng(address);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.blueAccent,size: 35,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white10,
      ),
    
      extendBody: true,
      body:SingleChildScrollView(
        child:Column(
          children: <Widget>[
            Container(
              child : ListTile(
                title : Text("Confirma tu dirección",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold)),
                subtitle : Text("* Para mayor precisión, pulsa y arrastra el marcador.",style: TextStyle(color: Colors.blueAccent))
              )
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.5,
              width: MediaQuery.of(context).size.width*0.9,
              child: GoogleMap(
                initialCameraPosition:CameraPosition(target: LatLng(userInfo.loca.latitude,userInfo.loca.longitude), zoom: 16.5),
                markers: Set.from(allMarkers),
                onMapCreated: mapCreated,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                //  onCameraMove: ((_position) => _updatePosition(_position)),
              ),
            ),
            _numberLogin(context)
      
          ],
        ),
      )
    );
  }

  Widget _numberLogin(BuildContext context){
    final size = MediaQuery.of(context).size;
    final userInfo   = Provider.of<UserInfo>(context);
    return  ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(top:size.height*0.05),
      children:<Widget>[
        Container(
          child:Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.directions),
                  labelText: 'Dirección',
                ),
                controller:directionController ,
              ),
              SizedBox(height: 40,),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.home),
                  labelText: 'Apartamento, Casa, Piso, Bloque',
                ),
                controller:aditionalController ,
              ),
            ],
          )
        ),
        Container(
          alignment: Alignment.bottomCenter,
          padding:EdgeInsets.only(bottom: size.height*0.04,left: 30,right: 30,top: 15),
          child:RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.all(0.0),
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF19AEFF), Color(0xFF139DF7),Color(0xFF0A83EE),Color(0xFF0570E5),Color(0xFF0064E0)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(20.0)
              ),
              child : Container(
                padding : EdgeInsets.fromLTRB(size.width*0.1, size.height*0.005, size.width*0.1,size.height*0.005),
                child : ListTile(
                  title:Text("Agregar",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,))
                ),
              ),
            ),
            onPressed: () { 
              // when  pressed  call service send Direction and add address of user
              if((directionController.text).contains('Cali')){
                _datas.add(_value+' '+directionController.text);
                var res= sendDirection.sendDirection(int.parse(prefs.token),'Cali',directionController.text,userInfo.loca.latitude,userInfo.loca.longitude,aditionalController.text);
                res.then((response) async {
                  if (response['response'] == 2){
                    Navigator.push(
                      context,  
                      MaterialPageRoute(
                        builder: (context) => Services()
                      )
                    );
                  }
                });
              }else{
                _onButtonPressed(context);
              }
            },
          )
        ),
      ]
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
            child: NoLocations(),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
              ),
            ),
          ),
        );
      }
    );
  }
  /* Extra Functions */
  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }
  movetoBoston() {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(42.3601, -71.0589), zoom: 14.0, bearing: 45.0, tilt: 45.0),
      )
    );
  }
  movetoNewYork() {
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(40.7128, -74.0060), zoom: 12.0),
      )
    );
  }
}