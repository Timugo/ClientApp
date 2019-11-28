import 'package:flutter/material.dart';
import 'model.dart';
import 'dart:math';
import 'dart:ui';

// Text('Hola '+model.firstName+'!', style: TextStyle(fontSize: 35)),

class Service extends StatelessWidget {
  Model model;

  Service({this.model});

  @override
 
     Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _fondoApp(),

          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _titulos(),
                _botonesRedondeados(context)
              ],
            ),
          )

        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(context)
    );
  }


  Widget _fondoApp(){

    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            Color.fromRGBO(255, 255, 255, 1.0),
            Color.fromRGBO(255, 255, 255, 1.0)
          ]
        )
      ),
    );


    final cajaRosa = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        height: 360.0,
        width: 360.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 255, 255, 1.0),
              Color.fromRGBO(13, 83, 215, 1.0)
            ]
          )
        ),
      )
    );
    
    final cajaAzul = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        height: 360.0,
        width: 360.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90.0),
          gradient: LinearGradient(
            colors: [
               Color.fromRGBO(20, 196, 193, 1.0),
             Color.fromRGBO(255, 255, 255, 1.0),
             
            ]
          )
        ),
      )
    );
    
    return Stack(
      children: <Widget>[
        gradiente,
        Positioned(
          top: -80.0,
          child: cajaRosa
        ),
        Positioned(
          top: 600,
          left: -120,
          child: cajaAzul,

        )
      ],
    );

  }

  Widget _titulos() {

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Text('Hola '+model.firstName+'!', style: TextStyle( color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold )),
            Text('Hola!', style: TextStyle( color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold )),
            SizedBox( height: 10.0 ),
            Text('Disfruta lo mejor  de Timugo.', style: TextStyle( color: Colors.white, fontSize: 15.0 )),
          ],
        ),
      ),
    );

  }

  Widget _bottomNavigationBar(BuildContext context) {

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
        primaryColor: Colors.pinkAccent,
        textTheme: Theme.of(context).textTheme
          .copyWith( caption: TextStyle( color: Color.fromRGBO(116, 117, 152, 1.0) ) )
      ),
      child: BottomNavigationBar(
        
        items: [
          BottomNavigationBarItem(
            icon: Icon( Icons.calendar_today, size: 30.0 ),
            title: Container()
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.bubble_chart, size: 30.0 ),
            title: Container()
          ),
          BottomNavigationBarItem(
            icon: Icon( Icons.supervised_user_circle, size: 30.0 ),
            title: Container()
          ),
        ],
      ),
    );

  }


  Widget _botonesRedondeados(BuildContext context) {

    return Table(
      children: [
        
        TableRow(
          children: [
                        _crearBotonRedondeado( Colors.black,'assets/images/barber.png', '  Corte de Cabello',context,'order'),
                        _crearBotonRedondeado( Colors.black, 'assets/images/arthur-humeau-Twd3yaqA2NM-unsplash.jpg', 'Depilacion',context,null),
                      ]
                    ),
                    TableRow(
                      children: [
                        _crearBotonRedondeado( Colors.black, 'assets/images/piel.png', 'mascarillas',context,null),
                        _crearBotonRedondeado( Colors.black, 'assets/images/piel.png', 'bbe',context,null),
                      ]
                    ),
                   
                  ],
                );
            
              }
            
            
    Widget _crearBotonRedondeado( Color color, String ruta, String texto,BuildContext context,String page) {

                  return Padding(
      padding: EdgeInsets.all(15.0),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, page),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: BackdropFilter(
              filter: ImageFilter.blur( sigmaX: 10.0, sigmaY: 10.0 ),
              child: Container(
                height: 180.0,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(62, 66, 107, 0.7),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox( height: 5.0 ),
                    Center(
                    child:new Container(

                             
                             
                             
                    child:
                      new CircleAvatar(
                        backgroundImage: AssetImage(ruta),
                          radius: 75.0,
                        
                            child: new Container(
                              padding: const EdgeInsets.all(0.0),
                                child: new Text(texto),
                          ),
                      ),
                           
                         
                        
                           ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
 
  }
}

















  
    
     
           
       
  
