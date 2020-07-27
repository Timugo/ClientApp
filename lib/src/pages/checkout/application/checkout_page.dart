//packages
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:screen_loader/screen_loader.dart';
import 'package:timugo/src/providers/user.dart';
//pages
import 'package:timugo/src/pages/directions/application/pages/directions_page.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/widgets/appbar.dart';
import 'package:timugo/src/widgets/buttonCustom.dart';
import 'package:timugo/src/widgets/toastMessage.dart';
import '../../orderinprocess/orderinprocces_page.dart';

//this class contains the user order summary and receive the following check in fields
class Checkout extends StatefulWidget {
  final List finalOrder;  
  final int servicePrice;
  final int aditionalsPrice;
  Checkout({this.finalOrder, this.servicePrice, this.aditionalsPrice});

  @override
  _CheckoutState createState() {
    return new _CheckoutState(finalOrder: finalOrder, aditionalsPrice: aditionalsPrice, servicePrice: servicePrice);
  }
}

class _CheckoutState extends State<Checkout>  with ScreenLoader<Checkout> {
  final List finalOrder;        // list containing the order
  final int servicePrice;       // price of additional services
  final int aditionalsPrice;    // price of base services 
  _CheckoutState({this.finalOrder, this.servicePrice, this.aditionalsPrice});
  @override
  loader() {
    return SpinKitCircle(
      color:Colors.blue,
    );
  }
  
  @override
  loadingBgBlur() => 10.0;

  @override
  Widget screen(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final prefs = new PreferenciasUsuario();
    final userInfo = Provider.of<UserInfo>(context);
    var dir = prefs.direccion == '' ? 'Elegir direccion' : '';

    return  Scaffold(
      appBar: MyAppBar(
        onPressed: (){
          Navigator.of(context).pop();
        }
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: size.width * 0.05,
                  top: size.height * 0.05,
                  bottom: size.height * 0.05
                ),
                child: Text(
                  "Resumen de Orden",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
              Card(
                child: ListTile(  
                  title: Text(userInfo.directions == ''
                    ? prefs.direccion + dir
                    : userInfo.directions
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: () => _onButtonPressed(context, AddDireccions()),
                  ),
                )
              ),
              Card(
                child: ListTile(
                  title: Text('Tiempo Estimado',),
                  trailing: Text('60 minutos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    )
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  trailing: RaisedButton.icon(
                    icon: Icon(Icons.keyboard_arrow_down),
                    onPressed: () {},
                    color: Colors.white,
                    label: Text('Cambiar', style: TextStyle(fontSize: 15)),
                  ),
                  leading: RaisedButton.icon(
                    color: Colors.green,
                    icon: Icon(Icons.attach_money),
                    onPressed: () {},
                    label: Text("Efectivo")
                  )
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                padding: EdgeInsets.only(
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  bottom: size.height * 0.1
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Costos',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 0),
                      title: Text('Servicios + Domicilio :'),
                      trailing: Text("\$" + servicePrice.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 0),
                      title: Text('Adicionales :'),
                      trailing: Text(
                        "\$" + aditionalsPrice.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18
                        )
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 0),
                      title: Text(
                        'Total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 22)
                      ),
                      trailing: Text("\$" + (servicePrice + aditionalsPrice).toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                  ],
                ),
              )
            ]
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: size.width * 0.05, top:  size.height * 0.8,left: size.width * 0.05,right: size.width * 0.05),
            child:MyCustomButtoms(
              hintText:  'Solicitar Servicio',
              onPressed:(){
                final preferencesUser = PreferenciasUsuario();
                final createOrdeProvider = CreateOrderProvider();
                var res = createOrdeProvider.createOrder(preferencesUser.direccion,'CASH',finalOrder);
                res.then((response) {
                  if (response['response'] == 2) {  
                    //Error
                    if (response['content']['code'] == 1) { 
                      //display the message with the reason
                      showToast( response['content']['message'], Colors.blue[200]);
                    } else {                     //if the order was created correctly
                      showToast( response['content']['message'], Colors.blue[200]);
                      Navigator.push(
                        context,  
                        MaterialPageRoute(
                          builder: (context) => OrderProcces()
                        )
                      );      
                    }
                  }else{
                    showToast("Ups... tenemos un error. Estamos solucionandolo", Colors.red);
                  }
                });
              },
              colors: [
                Color(0xFF19AEFF),
                Color(0xFF139DF7),
                Color(0xFF0A83EE),
                Color(0xFF0570E5),
                Color(0xFF0064E0)
              ]
            )
          )
        ]
      )
    );
  }

  _submitOrder() async {
    final preferencesUser = PreferenciasUsuario();
    final userInfo = Provider.of<UserInfo>(context);
    final createOrdeProvider = CreateOrderProvider();
    var res = createOrdeProvider.createOrder(
      preferencesUser.direccion,
      'CASH',
      finalOrder,
    );
    res.then((response) async {      //if the response is 2 = correct
      if (response['response'] == 2) {  //code ==1 its because the order cant be created for some reason
        if (response['content']['code'] == 1) { //display the message with the reason
          showToast( response['content']['message'], Colors.blue[200]);
          print("entre");
        } else {                     //if the order was created correctly
          showToast( response['content']['message'], Colors.blue[200]);
          Navigator.push(
            context,  
            MaterialPageRoute(
              builder: (context) => OrderProcces()
            )
          );      
        }
      }else{
        showToast("error", Colors.red);
      }
    });
  
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
      }
    );
  }
}
































 // Payments Implementations
    // primero ejecuto la funcion para verificar el pago , ya sea nequi , pse, credit
      //Para automaticos nequi ->  ['Corte de peloX1', 'Corte de baraba 50% off', 'Cejas'] array de 3 elements
      // enviar a pagina de verificando pago   response 2 y ACCEPTED then  create Orden
      // response 2  y REJECTED  verifico 6 segundo  description ''  devolver a checkout
      // pago unico sincrono ACCEPTED  -> response content  con codeQr
      // llamo  check push payment con el QR y lo  ejecuto hasta que responde accepted o rejected
      //   var res= createOrdeProvider.createOrder(int.parse(prefs.id),prefs.direccion,userInfo.city,finalOrder);
      //   //if the user have a direction  setted
 /* 
 _payment() {
    final prefs = PreferenciasUsuario();
    final createOrdeProvider = CreateOrderProvider();
    final userInfo = Provider.of<UserInfo>(context);

    if (userInfo.payment == 'Efectivo') {
      var res = createOrdeProvider.createOrder(
          int.parse(prefs.id), prefs.direccion, userInfo.city, finalOrder);
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
          int.parse(prefs.id), prefs.direccion, userInfo.city, finalOrder);
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
    for (var i in finalOrder) {
      String services = '';
      services = (i['nameService']) + 'X' + (i['quantity']).toString();
      pseDesc = pseDesc + ',' + services;
    }
    return pseDesc;
  }
 
 */
 