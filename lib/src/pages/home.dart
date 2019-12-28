//FLutter dependencies
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//pages 
import 'package:timugo/src/pages/registerData_page.dart';
import 'package:timugo/src/pages/services_pages.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:hidden_drawer_menu/menu/item_hidden_menu.dart';
import 'package:hidden_drawer_menu/hidden_drawer/screen_hidden_drawer.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ScreenHiddenDrawer> itens = new List();

  @override
  void initState() {
    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Menu 1",
          colorLineSelected: Colors.teal,
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.5), fontSize: 25.0 ),
          //selectedStyle: TextStyle(color: Colors.lightBlue),
        ),
        Services()));

    itens.add(new ScreenHiddenDrawer(
        new ItemHiddenMenu(
          name: "Menu 2",
          colorLineSelected: Colors.orange,
          baseStyle: TextStyle( color: Colors.white.withOpacity(0.5), fontSize: 25.0 ),
          //selectedStyle: TextStyle(color: Colors.lightBlue),
        ),
        RegisterData()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
          initPositionSelected: 0,
          screens: itens,
          backgroundColorMenu: Colors.black,
    //    typeOpen: TypeOpen.FROM_RIGHT,
          slidePercent: 60.0,
    //    verticalScalePercent: 80.0,
          contentCornerRadius: 40.0,
          iconMenuAppBar: Icon(FontAwesomeIcons.userCircle,color: Colors.black,),
    //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
          whithAutoTittleName: false,
    //    styleAutoTittleName: TextStyle(color: Colors.red),
          actionsAppBar: <Widget>[  
                        Spacer(),
                        IconButton(icon:Icon(FontAwesomeIcons.search,color: Colors.black,),onPressed: (){},),
                        Stack(
                          children: <Widget>[
                          IconButton(icon:Icon(FontAwesomeIcons.headset,color: Colors.black,),onPressed: (){},),
                          Container(
                            child: Center(child: Text('1',style: TextStyle(color: Colors.white ),)),
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20.0)
                            ),
                          )

                          ],
                        ),
                        IconButton(icon:Icon(FontAwesomeIcons.ellipsisV,size: 15.0,color: Colors.black),onPressed: (){},),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            width: 50.0,
                            height: 50.0,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 15.0,)

          ],
          //backgroundColorContent: Colors.blue,
          backgroundColorAppBar: Colors.white,
          elevationAppBar: 0.0,
    //    tittleAppBar: Center(child: Icon(Icons.ac_unit),),
    //    enableShadowItensMenu: true,
    //    backgroundMenu: DecorationImage(image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
        );
  }
}