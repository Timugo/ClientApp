//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timugo/src/providers/user.dart';
//pages
import 'package:timugo/src/widgets/addDirections.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'orderProcces_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

//this class contains the user order summary
class Checkout extends StatefulWidget {
  final List temp;
  final int price;
  final int priceA;
  Checkout({this.temp, this.price, this.priceA});

  @override
  _CheckoutState createState() {
    return new _CheckoutState(temp: temp, priceA: priceA, price: price);
  }
}

class _CheckoutState extends State<Checkout> {
  final List temp;
  final int price;
  final int priceA;
  _CheckoutState({this.temp, this.price, this.priceA});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final prefs = new PreferenciasUsuario();
    final userInfo = Provider.of<UserInfo>(context);
    var dir =prefs.direccion == '' ?'Elegir direccion':'';

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 35,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white10,
        ),
        body: Stack(children: <Widget>[
          ListView(children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  left: size.width * 0.05,
                  top: size.height * 0.05,
                  bottom: size.height * 0.05),
              child: Text("Resumen de Orden",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ),
            Card(
                child: ListTile(
              title: Text(userInfo.directions == '' ? prefs.direccion+dir:userInfo.directions),
              trailing: IconButton(
                icon: Icon(Icons.arrow_drop_down),
                onPressed: () => _onButtonPressed(context, AddDireccions()),
              ),
            )),
            Card(
              child: ListTile(
                title: Text(
                  'Tiempo Estimado',
                ),
                trailing: Text('30 -45 min',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            ),
            Card(
              child: ListTile(
                  trailing: RaisedButton.icon(
                    icon: Icon(Icons.keyboard_arrow_down),
                    onPressed: () {
                      //  { Navigator.push(
                      //       context,
                      //         MaterialPageRoute(
                      //           builder: (context) => Payment()
                      //         ));
                    },
                    color: Colors.white,
                    label: Text('Cambiar', style: TextStyle(fontSize: 15)),
                  ),
                  leading: RaisedButton.icon(
                    color: Colors.green,
                    icon: Icon(Icons.attach_money),
                    onPressed: () {},
                    label: Text("Efectivo"
                        // (prefs.payment != null &&
                        //         userInfo.payment == 'Efectivo')
                        //     ? prefs.payment
                        //     : userInfo.payment,
                        // style: TextStyle(fontSize: 20)),
                  ))),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              padding: EdgeInsets.only(
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  bottom: size.height * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Resumen',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text('Costo del servicio :'),
                    trailing: Text("\$" + price.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text('Costos adiccionales :'),
                    trailing: Text("\$" + priceA.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    title: Text('Total a cobrar',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22)),
                    subtitle: Text('Con efectivo'),
                    trailing: Text("\$" + (price + priceA).toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                ],
              ),
            )
          ]),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: size.height * 0.04),
            child: RaisedButton(
              elevation: 5.0,
              onPressed: () {
                final userInfo = Provider.of<UserInfo>(context);
                // primero ejecuto la funcion para verificar el pago , ya sea nequi , pse, credit
                //Para automaticos nequi ->  ['Corte de peloX1', 'Corte de baraba 50% off', 'Cejas'] array de 3 elements
                // enviar a pagina de verificando pago   response 2 y ACCEPTED then  create Orden
                // response 2  y REJECTED  verifico 6 segundo  description ''  devolver a checkout
                // pago unico sincrono ACCEPTED  -> response content  con codeQr
                // llamo  check push payment con el QR y lo  ejecuto hasta que responde accepted o rejected
                //   var res= createOrdeProvider.createOrder(int.parse(prefs.id),prefs.direccion,userInfo.city,temp);
                //   //if the user have a direction  setted
                if (prefs.direccion != null || userInfo.directions != '') {
                  final createOrdeProvider = CreateOrderProvider();
                  var res = createOrdeProvider.createOrder(
                      int.parse(prefs.id),
                      prefs.direccion != null
                          ? prefs.direccion
                          : userInfo.directions,
                      userInfo.city,
                      temp);

                  res.then((response) async {
                    //if the response is 2 = correct
                    if (response['response'] == 2) {
                      //code ==1 its because the order cant be created for some reason
                      if (response['content']['code'] == 1) {
                        //diaplay the message with the reason
                        _showMessa(
                            response['content']['message'], Colors.blue[200]);
                      } else {
                        //if the order was created correctly
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderProcces()));
                      }
                    }
                  });
                } else {
                  _showMessa("Por favor  elige una direccion!", Colors.red);
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              padding: EdgeInsets.all(0.0),
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
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      size.width * 0.25,
                      size.height * 0.02,
                      size.width * 0.25,
                      size.height * 0.02),
                  child: Text(
                    'Enviar pedido' + ' ' + "\$" + (price + priceA).toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ]));
  }

  _payment() {
    final prefs = PreferenciasUsuario();
    final createOrdeProvider = CreateOrderProvider();
    final userInfo = Provider.of<UserInfo>(context);

    if (userInfo.payment == 'Efectivo') {
      var res = createOrdeProvider.createOrder(
          int.parse(prefs.id), prefs.direccion, userInfo.city, temp);
      //if the user have a direction  setted
      if (prefs.direccion != '') {
        res.then((response) async {
          //if the response is 2 = correct
          if (response['response'] == 2) {
            //code ==1 its because the order cant be created for some reason
            if (response['content']['code'] == 1) {
              //diaplay the message with the reason
              _showMessa(response['content']['message'], Colors.blue[200]);
            } else {
              //if the order was created correctly
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderProcces()));
            }
          }
        });
      } else {
        _showMessa("Por favor  elige una direccion!", Colors.red);
      }
    }

    if (userInfo.payment == 'Tarjeta') {
      var res = createOrdeProvider.createOrder(
          int.parse(prefs.id), prefs.direccion, userInfo.city, temp);
      //if the user have a direction  setted
      if (prefs.direccion != '') {
        res.then((response) async {
          //if the response is 2 = correct
          if (response['response'] == 2) {
            //code ==1 its because the order cant be created for some reason
            if (response['content']['code'] == 1) {
              //diaplay the message with the reason
              _showMessa(response['content']['message'], Colors.blue[200]);
            } else {
              //if the order was created correctly
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderProcces()));
            }
          }
        });
      } else {
        _showMessa("Por favor  elige una direccion!", Colors.red);
      }
    }
  }

  String _pseDescription() {
    String pseDesc = '';
    for (var i in temp) {
      String services = '';
      services = (i['nameService']) + 'X' + (i['quantity']).toString();
      pseDesc = pseDesc + ',' + services;
    }
    return pseDesc;
  }

  _showMessa(String msj, Color color) {
    // show the toast message in bell appbar
    Fluttertoast.showToast(
        msg: msj,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  void _onButtonPressed(BuildContext context, Widget ruta) {
    final size = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: size * 0.75,
            child: Container(
              child: ruta,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }
}
