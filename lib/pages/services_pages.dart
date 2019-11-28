import 'package:flutter/material.dart';
import 'package:timugo_client_app/pages/menu_widget.dart';
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
       appBar: AppBar(
        title: Text('Preferencias de Usuario'),
      ),
      drawer: MenuWidget(),
      body: Stack(
        children: <Widget>[
           _profile(context),
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


  Widget _titulos() {

    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Text('Hola '+model.firstName+'!', style: TextStyle( color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold )),
            Text('Hola!', style: TextStyle( color: Colors.black, fontSize: 35.0, fontWeight: FontWeight.bold )),
            SizedBox( height: 10.0 ),
            Text('Disfruta lo mejor  de Timugo.', style: TextStyle( color: Colors.black, fontSize: 15.0 )),
          ],
        ),
      ),
    );

  }

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
                  children: <Widget>[
                    FunctionalButton(
                      icon: Icons.arrow_left,
                      title: "",
                      onPressed: () {},
                    ),
                    PriceWidget(
                      price: "0.00",
                      onPressed: () {},
                    ),
                    ProfileWidget(onPressed: () => Navigator.pushNamed(context, '/notifications'),),
                  ],
                ),
              ),
            ),
          ),
         
        ],
      )
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
            "assets/images/piel.png",
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
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 10),
              shape: BoxShape.circle),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              shape: BoxShape.circle,
            ),
            child: RawMaterialButton(
              onPressed: widget.onPressed,
              splashColor: Colors.black,
              fillColor: Colors.blue,
              elevation: 15.0,
              shape: CircleBorder(),
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(widget.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28))),
            ),
          ),
        ),
      ],
    );
  }
}

















  
    
     
           
       
  
