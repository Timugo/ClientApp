import 'package:flutter/material.dart';
import 'package:timugo_client_app/pages/menu_widget.dart';


//Widget
import 'model.dart';



class Service extends StatelessWidget {
  Model model;

  Service({this.model});

  @override
    Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(

      iconTheme: new IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),

      drawer: MenuWidget(),
      body: Stack(
        children: <Widget>[
           _profile(context),
          SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                

              children: <Widget>[
              

               
                _titles(),
              
                _botonesRedondeados(context)
              ],
            ),
          )

        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(context)
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
                ),
              ),
            ),
          ),
         
        ],
      )
    );
  }


  Widget  _titles(){

    return Container(
      
      
      padding: new EdgeInsets.all(15.0),
      child: Column(
         children: <Widget>[

            SizedBox(height: 30.0),
            Align(alignment: Alignment.centerLeft,child: Text('Hola!', style: TextStyle( color: Colors.black, fontSize: 35.0,fontWeight:FontWeight.w300 )),),
            SizedBox(height: 5.0),
            Align(alignment: Alignment.centerLeft,child: Text('Anderson', style: TextStyle( color: Colors.black, fontSize: 35.0 , fontWeight: FontWeight.bold ),),),
            SizedBox( height: 50.0 ),
            Text('Servicios', style: TextStyle( color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.w800 ),),
              SizedBox( height: 10.0 ),
            new Container(height: 1,  color: Colors.black,
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),),
         ]
      )
    );
    }

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
            icon: Icon( Icons.shopping_basket, size: 30.0 ),
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
                Navigator.pushNamed(context, 'services');
                break;
              case 2:
                Navigator.pushNamed(context, 'services');
                break;
            }
          }
      ),
        
      );
    

  }


  Widget _botonesRedondeados(BuildContext context) {

    return Table(
      children: [
        
        TableRow(
          children: [
            _crearBotonRedondeado( Colors.black,'assets/images/barb.jpg', '  Corte de Cabello',context,'order',1.0),
            _crearBotonRedondeado( Colors.black, 'assets/images/barba2.jpg', 'corte solo Barba',context,'skeleton',0.5),
          ]
            ),
        TableRow(
          children: [
            _crearBotonRedondeado( Colors.black, 'assets/images/piel.png', 'mascarillas',context,null,0.5),
            _crearBotonRedondeado( Colors.black, 'assets/images/convenios.jpg', 'Aliados',context,null,0.5),
          ]
        ),
      ],
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
                          child:Image.asset(ruta)
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















  
    
     
           
       
  
