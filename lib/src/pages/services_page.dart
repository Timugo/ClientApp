//Flutter dependencies
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timugo/src/pages/menu_widget.dart';
import 'package:timugo/src/pages/orderProcces_page.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/widgets/addDirections.dart';

//Pages
import 'package:timugo/src/widgets/cardsServices.dart';
import 'package:timugo/src/widgets/cardsBarbers.dart';
import 'package:timugo/src/widgets/circularBackground.dart';
import 'package:timugo/src/services/number_provider.dart';

 
 // This class contains the principal  services of Timugo and  show the  Barbers Top
class Services extends StatefulWidget {
 
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>(); // global key of scaffol
  @override

  Widget build(BuildContext context) {
    
    final  prefs    = new PreferenciasUsuario();  
    final  userName = UserProvider();
    final  userInfo = Provider.of<UserInfo>(context);
    final checkUserOrder =CheckUserOrder();
    userName.getName(prefs.token); // call to pref user that contains the data  save in the device
    checkUserOrder.checkUserOrder();
    var dir =prefs.direccion == '' ?'Elegir direccion':'';
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        leading: new IconButton(
          icon:Icon(FontAwesomeIcons.userCircle,size: 25.0,color: Colors.black),
          onPressed: () => _scaffoldKey.currentState.openDrawer()), // This function Open Menu widget
        actions: <Widget>[
          SizedBox(width: 15.0,),
          Spacer(),
          FlatButton.icon(   // show  actual address of user and open the page add directions
            label: Text(userInfo.directions == '' ? prefs.direccion+dir:userInfo.directions,),
            icon: Icon(Icons.arrow_drop_down),
            onPressed: () => _onButtonPressed(context),
          ),
          Spacer(),
          Stack(
            children: <Widget>[
              IconButton(
                icon:Icon(FontAwesomeIcons.bell,color: Colors.black,),
                onPressed:(){  // contains the bell function that show '1' if user have orders  and redirect to  order pages
                  if(prefs.order == '0'){
                    _showMessa();
                  }
                  else{
                    Navigator.push(
                    context,MaterialPageRoute(
                    builder: (context) =>OrderProcces()));
                  }
              },),
              Container(
                child: Center(
                  child: Text(prefs.order == '0' ? '':'1',style: TextStyle(color: Colors.white ),)),
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    color: prefs.order == '0' ? Colors.white :Colors.red,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
              )
            ],
          ),
          IconButton(
            icon:Icon(FontAwesomeIcons.ticketAlt,size: 15.0,color: Colors.black),
            onPressed: (){},
          ), 
          SizedBox(width: 8.0,)
        ],
      ),
     drawer: MenuWidget(), // open the menu Drawer page
     body:Stack( // call  the  carsd of services and barbers of services pages 
        children: <Widget>[
          CircularBackGround(),
          SafeArea(
            child: SingleChildScrollView(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _Header(),
                  SizedBox(height: 25,),
                  CardsServices(),
                  _HeaderBarbers(),
                  CardsBarbers(),
                ],
              ) ,
            ),
          ),
        ],
      ),
    ); 
  }
  _showMessa(){ // show the toast message in bell appbar
    Fluttertoast.showToast(
      msg: "Aún no tienes ordenes en curso!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0
    );

  }
    
void _onButtonPressed(BuildContext context) { // show de modal botton sheet tha open the  add Directions widget
     final size = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: size*0.75,
            child: Container(
              child: AddDireccions(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          );
        });
  }
}


// this class contains the  services card and put the titles in the page services
class  _Header extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start ,
        children: <Widget>[
          SizedBox(height: 20.0,),
          Text('Servicios',style:TextStyle(fontWeight:FontWeight.bold,fontSize:30.0)),
          Text('¿Que quieres pedir hoy?',style:TextStyle(fontWeight:FontWeight.w100,fontSize:18.0))

        ],
      ),
    );
  }
}

// this class contains the  barbers card and put the titles in the page services
class  _HeaderBarbers extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start ,
        children: <Widget>[
          SizedBox(height: 40.0,),
          Text('Barberos',style:TextStyle(fontWeight:FontWeight.bold,fontSize:25.0)),
          Row(
            children: <Widget>[
              Icon(FontAwesomeIcons.fire,color: Colors.red,),
              SizedBox(width: 15.0,),
              Text('Nuestros Barberos más Top',style:TextStyle(fontWeight:FontWeight.w100,fontSize:18.0)),
              SizedBox(width: 15.0,),
              Icon(FontAwesomeIcons.fire,color: Colors.red,)
            ],
          ),
        ],
      ),
    );
  }
}
// this class contains the  buy button  card and put the title in the  card services

class BuyButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) { 
    final size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Pedir',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
                SizedBox(width: 5.0,),
                Icon(FontAwesomeIcons.arrowRight,color: Colors.white,)
              ],
            ),
            width: size.width*0.3,
            height: 60.0,
            decoration: BoxDecoration(
              color:Colors.red,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0))
            ),
          ),
        )
      ],
    );
  }
}

