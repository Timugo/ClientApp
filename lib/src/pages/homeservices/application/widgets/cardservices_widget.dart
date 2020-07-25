import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/* Enviroments*/
import 'package:timugo/globals.dart' as globals;
import 'package:timugo/src/interfaces/server_response.dart';
/* Pages */
import 'package:timugo/src/pages/checkin/application/checkin_page.dart';
import 'package:timugo/src/pages/homeservices/domain/services_model.dart';
import 'package:timugo/src/providers/user.dart';
/* Services */
import 'package:timugo/src/services/number_provider.dart';
import 'package:timugo/src/widgets/toastMessage.dart';
class CardsServices extends StatelessWidget {
  const CardsServices({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final servicesProvider = ServicesProvider();
    return FutureBuilder(
      future: servicesProvider.getServices(),
      builder: (context,AsyncSnapshot<List<ServicesModel>> snapshot) {
        if (snapshot.hasData) {
          final services = snapshot.data;
          return Container(
            width: size.width,
            height: size.width > size.height
                ? size.height * 0.60
                : size.height * 0.40,
            child: PageView.builder(
              controller: PageController(
                viewportFraction: size.width > size.height ? 0.4 : 0.7
              ),
              pageSnapping: false,
              itemCount: services.length,
              itemBuilder: (context, i) => _Card(services[i]),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });
  }
}

class _Card extends StatelessWidget {
  final  ServicesModel prod;
  //Constructor
  _Card(this.prod);
  
  @override
  Widget build(BuildContext context) {
    // Data server Url
    final String  url = globals.url;
    final size = MediaQuery.of(context).size;
    final userInfo = Provider.of<UserInfo>(context);
    userInfo.urlImg = prod.urlImg;
    return GestureDetector(
      onTap: (){
        _onCardTap(context);
      },
      child:Container(
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                _DescriptionCard(prod,_onCardTap(context)),
              ],
            ),
          
            Positioned(
              top: size.width>size.height ? size.height*0.0 : size.height*0.0,
              bottom: size.width>size.height ? size.height*0.14 : size.height*0.11,
              left: size.width>size.height ? size.width*0.05 : size.width*0.09,
              child: Image.network(url+prod.urlImg,
                width: size.width>size.height ? size.height*0.22 : size.height*0.15,
                height: size.width>size.height ? size.height*0.22 : size.height*0.15,
              )
            )
          ],
        ),
      )
    );
  }

  _onCardTap(context) {
    final checkUserOrder = CheckUserOrder();
    checkUserOrder.checkUserOrder()
      .then((response) {
        print(response.body);
        //final resp = iServerResponseFromJson(response.body);
        var res = jsonDecode(response.body); 
        if (res["response"] == 1) {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => Checkin(model: prod))
          );
        } else if(res["response"] ==2 ) {
          showToast("Aún tienes una orden en curso!", Color(0xFF0570E5));
        }
      })
      .catchError((onError){
        print(onError);
      });
  }

}
class _DescriptionCard extends StatelessWidget {
  final ServicesModel prod;
  final Function _onTap;
  _DescriptionCard(this.prod,this._onTap);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return new GestureDetector(
      onTap: () => _onTap(),   
      child: Card(  
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width:size.width>size.height ? size.height*0.40 :size.height*0.28, ///////////////////////////////////////
            height: size.height,
            color : Color(0xff000000),
            child: Column(

              children: <Widget>[
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Spacer(),
                      Text('${prod.name}',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold)),
                      Spacer(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: Text('\$'+'${prod.price}',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
                      width: size.width>size.height ? size.width*0.1 : size.width*0.17,
                      //height: size.height*0.05,
                    ),
                    Container(
                      child:RaisedButton(
                        color: Color(0xFF0570E5),
                        child:Text('Solicitar',style: TextStyle(color: Colors.white)),
                        onPressed: () => _onTap
                      ),
                      width: 100.0,
                      height: 35,
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15))
                      ) ,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );  
  }

}



