
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' show Random;
import 'package:timugo_client_app/models/dataClient_models.dart';
import 'package:timugo_client_app/providers/register_provider.dart';
import 'package:timugo_client_app/providers/sqlite_providers.dart';

import 'model_order.dart';

class Order extends StatefulWidget {
  Order({Key key, this.title}) : super(key: key);
  final String title;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Order> {
  final Map<String, Marker> _markers = {};
  final  ordeProvider = OrderProvider();
  OrderModel order = OrderModel();
  bool _visible = true;
  _MyHomePageState();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  Completer<GoogleMapController> _controller = Completer();
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
  int _polylineIdCounter = 1;
  PolylineId selectedPolyline;

  static final CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(3.4372201,-76.5224991),
    zoom: 17.0,
  );
  var rnd = new Random(1).nextInt(10-1);
  var state = true;

  @override
  void initState() {
    //_mapController.mar();s
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      bottomNavigationBar: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 11, offset: Offset(3.0, 4.0))
          ],
        ),
        
         child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                  Container(
                    height: 0,
                    width: 0,
                  child:FutureBuilder<List<DataClient>>(
                  future: ClientDB.db.getClient(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                  Text('');
                    if(snapshot.hasData) {
                     DataClient item = snapshot.data[0];
                     order.idClient=item.id;
                     order.address=item.address;
                     order.typeService=1;
                     print(order);
                    }
                    Text('');
                    }
                  
                    ),
                  ),
                    Text('Hay actualmente'+' '+rnd.toString()+' '+'barberos en tu sector ...',style: TextStyle( color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w800),),
                     SizedBox(height: 20.0),
                    GoButton(
                      title: "Pedir",
                      onPressed:() 
                       {if (state = false){
                        return null;

                       }else{
                      {_getLocation();
                        Timer.run((){
                        state = false;
                        showDialog(
                        
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: new Text("Su servicio fue tomado con exito"),
                            actions: <Widget>[
                              new FlatButton(
                                child: new Text("Cerrar"),
                                onPressed: () {
                                   var res= ordeProvider.createOrder(order);
                                    res.then((response) async {
                                      print(res);
                                      if (response['response'] == 2){
                                
                                       Navigator.pushNamed(context, 'transaction');
                                      //    builder: (context) => Login()));


                                      }

                                    });
                                  
                                },
                              ),
                            ],
                          );
                        }
                       );
                     });

                    

                      }
                      }

                      
                       }
                    )
                  ]

         ),
      ),
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      bottomSheet: Container(
        height: 50,
        decoration: BoxDecoration(color: Colors.black),
        child: Column(),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            polylines: Set<Polyline>.of(polylines.values),
            mapType: MapType.normal,
            initialCameraPosition: _cameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              //_initCameraPosition();
            },
            markers: _markers.values.toSet(),

          ),
          
          Positioned(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FunctionalButton(
                      icon: Icons.arrow_left,
                      title: "",
                      onPressed: () => Navigator.pushNamed(context, 'services'),
                    ),
                    PriceWidget(
                      price: "15.000",
                      onPressed: () {},
                    ),
                    ProfileWidget(
                      onPressed: () => Navigator.pushNamed(context, 'notificaciones'),),
                  ],
                ),
              ),
            ),
          ),
         
        ],
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition:  CameraPosition(target: LatLng(3.712776, -76.505974), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        ),
    );
  }
    void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    setState(() {
      _markers.clear();
      final marker = Marker(
          markerId: MarkerId("curr_loc"),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          infoWindow: InfoWindow(title: 'Mi Ubicacion'),
      );
      _markers["Current Location"] = marker;
      _gotoLocation(currentLocation.latitude, currentLocation.longitude);

    });
  }

   Future<void> _gotoLocation(double lat,double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, long), zoom: 15,tilt: 50.0,
      bearing: 45.0,)));
  }



   
}



class FunctionalButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function() onPressed;

  const FunctionalButton({Key key, this.title, this.icon, this.onPressed})
      : super(key: key);

  @override
  _FunctionalButtonState createState() => _FunctionalButtonState();
}

class _FunctionalButtonState extends State<FunctionalButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RawMaterialButton(
          onPressed: widget.onPressed,
          splashColor: Colors.black,
          fillColor: Colors.white,
          elevation: 15.0,
          shape: CircleBorder(),
          child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Icon(
                widget.icon,
                size: 30.0,
                color: Colors.black,
              )),
        ),
      ],
    );
  }
}

class ProfileWidget extends StatefulWidget {
  final Function() onPressed;

  const ProfileWidget({Key key, this.onPressed}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
          child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 4),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: 11, offset: Offset(3.0, 4.0))
          ],
        ),
       child: ClipOval(
          child: Image.asset(
            "assets/images/profile.png",
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        ),
    );
  }
}

class PriceWidget extends StatefulWidget {
  final String price;
  final Function() onPressed;

  const PriceWidget({Key key, this.price, this.onPressed}) : super(key: key);

  @override
  _PriceWidgetState createState() => _PriceWidgetState();
}

class _PriceWidgetState extends State<PriceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 4),
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey, blurRadius: 11, offset: Offset(3.0, 4.0))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("\$",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
          Text(widget.price,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class GoButton extends StatefulWidget {
  final String title;
  final Function() onPressed;

  const GoButton({Key key, this.title, this.onPressed}) : super(key: key);

  @override
  _GoButtonState createState() => _GoButtonState();
}

class _GoButtonState extends State<GoButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
        
            child: RawMaterialButton(
              
              onPressed: widget.onPressed,
              splashColor: Colors.black,
              fillColor: Color.fromRGBO(5,112, 219,1.0),
              elevation: 15.0,
              shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0)),
              
            
            
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(widget.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28))),
                          
            ),
          ),
        
      ],
    );
  }


  
}

