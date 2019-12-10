import 'package:flutter/material.dart';
import 'package:timugo_client_app/models/dataClient_models.dart';
import 'package:timugo_client_app/pages/menu_widget.dart';
import 'package:timugo_client_app/providers/register_provider.dart';
import 'package:timugo_client_app/providers/sqlite_providers.dart';
import 'package:url_launcher/url_launcher.dart';




//Class Service 
class Service extends StatelessWidget {

  final  serviceProvider = ServicesProvider();
  @override
    Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(

      iconTheme: new IconThemeData(color: Colors.blue),
        backgroundColor: Colors.white,
      ),

      drawer: MenuWidget(),
      body:FutureBuilder<List<DataClient>>(
      
        future: ClientDB.db.getClient(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Text('');
          if(snapshot.hasData) {
            DataClient item = snapshot.data[0];
            return Stack (
              children: <Widget>[
                _profile(context),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _titles(item),    // titles of welcome to app              
                      _botonesRedondeados(context)  // row of celds  , services
                    ],
                  ),
                )
              ],
            );
          }
        }
      ),
      bottomNavigationBar: _bottomNavigationBar(context)  // Botton of Navigation  
    );
  }

  // spaces and padding to tittles
  Widget _profile(BuildContext context){

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
              ),
            ),
          ),
         
        ],
      )
    );
  }
  // Welcome to the app and name of user

  Widget  _titles(DataClient item){
    return Container(
      padding: new EdgeInsets.all(15.0),
      child: Column(
         children: <Widget>[

            SizedBox(height: 30.0),
            Align(alignment: Alignment.centerLeft,child: Text('Hola!', style: TextStyle( color: Colors.black, fontSize: 40.0,fontWeight:FontWeight.w300 )),),
            SizedBox(height: 5.0),
            Align(alignment: Alignment.centerLeft,child: Text(item.name[0].toUpperCase()+item.name.substring(1), style: TextStyle( color: Colors.black, fontSize: 55.0 , fontWeight: FontWeight.bold ),),),
            SizedBox( height: 50.0 ),
            Text('Servicios', style: TextStyle( color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.w800 ),),
              SizedBox( height: 10.0 ),
            new Container(height: 1,  color: Colors.blue,
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),),
         ]
      )
    );
    }
  // widget that contain  3 icons   for navigartion  app
  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(255, 255, 255, 1.0),
        primaryColor: Colors.blueAccent,
        textTheme: Theme.of(context).textTheme
          .copyWith( caption: TextStyle( color: Color.fromRGBO(3, 3, 3, 1) ) )
      ),
      child: BottomNavigationBar(
        
        items: [
          BottomNavigationBarItem(
            icon: Icon( Icons.add_shopping_cart, size: 30.0 ),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.headset_mic, size: 30.0 ),
            title: Container()
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.notifications, size: 30.0 ),
            title: Container()
          ),
        ],

        onTap: (index) {
          switch (index) {
              case 0:
               Navigator.pushNamed(context, 'services');
               break;
              case 1:
                _launchURL();
                break;
              case 2:
                Navigator.pushNamed(context, 'transaction');
                break;
            }
          }
      ),
      );
    

  }

  // widget that  do  the services buttons
  Widget _botonesRedondeados(BuildContext context) {


  
     
     

    return Table(
      children: [
        
        TableRow(
          children: [
            _crearBotonRedondeado( Colors.black,'assets/images/services/hairCut.jpg', 'Corte de cabello',context,'order',1.0),
            _crearBotonRedondeado( Colors.black, 'assets/images/services/beard.jpg', 'Corte solo Barba',context,null,0.5),
          ]
            ),
        TableRow(
          children: [
            _crearBotonRedondeado( Colors.black, 'assets/images/services/mask.png', 'Mascarillas',context,null,0.5),
            _crearBotonRedondeado( Colors.black, 'assets/images/services/alliances.jpg', 'Aliados',context,null,0.5),
          ]
        ),
      ]
    );
    
  }
     
  
                
            
            
    Widget _crearBotonRedondeado( Color color, String ruta, String texto,BuildContext context,String page,double opacidad) {

                  return Padding(
      padding: EdgeInsets.all(15.0),
      child:Opacity(
       opacity: opacidad,

        

        child: GestureDetector(
          onTap:() {if (page == null) {
             showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: new Text("Servicio proximamente"),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("Cerrar"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
              );
              } else {
                Navigator.pushNamed(context, page);
                }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    height: 200.0,
                    width: 200.0,
                    child: Column(
                      children: <Widget>[
                      Container(
                        
                          height: 180.0,
                          child:Image.network('http://167.172.216.181:3000/'+ruta)
                      ),
                      Text( texto , style: TextStyle( color: color,fontSize: 15, fontWeight: FontWeight.bold)
                      ),
      
                      ]
                  ),
                ),
             ),
           ),
      )
     );
 
    }
}

_launchURL() async {
  const url = 'https://wa.me/573106838163?text=Hola%20soy%20Nombre%20Necesito%20asistencia%20con%20Timugo';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}













  
    
     
           
       
  
