// packages
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
//provuiders
import 'package:provider/provider.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:timugo/src/providers/barber_provider.dart';
//models
import 'package:timugo/src/models/temporalOrder_model.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
//pages
import 'package:timugo/src/pages/homeservices/application/services_page.dart';
import 'widgets/editorder_widget.dart';
import 'package:timugo/globals.dart' as globals;




class OrderProcces extends StatefulWidget {
  @override
  _ProccesState createState() {
    return new _ProccesState();
  }
}

class _ProccesState extends State<OrderProcces> {
  final int cant;

  _ProccesState({this.cant});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final prefs = new PreferenciasUsuario();

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 35,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Services()));
            },
          ),
          actions: <Widget>[
            Container(
                padding: EdgeInsets.only(right: size.width * 0.04),
                child: IconButton(
                    icon:
                        Icon(Icons.headset_mic, color: Colors.black, size: 35),
                    onPressed: () async {
                      var whatsappUrl =
                          "whatsapp://send?phone=${573106838163}?text=Hola mi nombre es " +
                              prefs.name +
                              " y necesito ayuda con mi orden de Timugo'";
                      await canLaunch(whatsappUrl)
                          ? launch(whatsappUrl)
                          : print(
                              "No se encontro el link o whatsapp no instalado");
                    }
                    //FlutterOpenWhatsapp.sendSingleMessage("573106838163", "Hola mi nombre es "+prefs.name+' y necesito ayuda con mi orden de Timugo');

                    ))
          ],
          backgroundColor: Colors.white10,
        ),
        body: Stack(children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: size.width * 0.04, top: size.height * 0.01),
            child: Text("Orden en Curso",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.only(
                left: size.width * 0.04, top: size.height * 0.1),
            child: Text("Tu Barbero",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          _barber(),
          Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: size.height * 0.01),
              child: _buttonadd()),
          Container(
              margin: EdgeInsets.only(
                  left: size.width * 0.04,
                  right: size.width * 0.04,
                  top: size.height * 0.35),
              child: Divider(
                color: Colors.black,
              )),
          Container(
            padding: EdgeInsets.only(
                left: size.width * 0.04, top: size.height * 0.38),
            child: Text("Resumen de Orden",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
              padding: EdgeInsets.only(
                  top: size.height * 0.42, bottom: size.height * 0.08),
              alignment: Alignment.bottomCenter,
              child: _crearListado())
        ]));
  }

  Widget _barber() {
    final barberAsigned = Provider.of<BarberAsigned>(context);
    final size = MediaQuery.of(context).size;
    var urlI ='https://i.pinimg.com/736x/a4/93/25/a493253f2b9b3be6ef48886bbf92af58.jpg';
    final String baseUrl = globals.url;
    if (barberAsigned.name == 'Sin Asignar') {
      _getBarber();
    }
    return Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.only(top: size.height * 0.13),
          child: Row(children: <Widget>[
            CircleAvatar(
              radius: size.height * 0.08,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                  backgroundImage: NetworkImage(barberAsigned.urlImg == ''
                      ? urlI
                      : baseUrl + barberAsigned.urlImg),
                  radius: size.width * 20),
            ),
            Text(barberAsigned.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              width: 10,
            )
          ])),
      SizedBox(height: 10),
      Container(
          padding: EdgeInsets.only(top: size.height * 0.3),
          child: ListTile(
            title: Text(barberAsigned.phone,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            leading: IconButton(
                icon: Icon(
                  Icons.call,
                  color: Color(0xFF0570E5),
                ),
                onPressed: () => launch("tel://" + barberAsigned.phone)),
          )),
    ]);
  }

  void _getBarber() {
    final barberAsigned = Provider.of<BarberAsigned>(context);
    final temporalOrderProvider = TemporalOrderProvider();
    final prefs = PreferenciasUsuario();
    var res = temporalOrderProvider.getBarberAsigned();

    res.then((response) async {
      if (response['response'] == 2 &&
          response['content']['barber']['name'] != 'Sin') {
        print(response['content']['barber']);
        barberAsigned.name = (response['content']['barber']['name']);
        barberAsigned.stairs = (response['content']['barber']['stairs']) * 1.0;
        barberAsigned.urlImg = (response['content']['barber']['urlImg']);
        barberAsigned.phone =
            (response['content']['barber']['phone']).toString();
      } else {
        if (response['response'] == 1) {
          prefs.order = '0';
        }
      }
    });
  }

  Widget _buttonadd() {
    final size = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              elevation: 5.0,

              onPressed: () {
                _onButtonPressed(context);
              }, // monVal == false ? null:   _subimit ,
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
                    borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                    padding: EdgeInsets.fromLTRB(
                        size.width * 0.18,
                        size.height * 0.02,
                        size.width * 0.18,
                        size.height * 0.02),
                    child: Text('Editar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ))),
              ),
            ),
            RaisedButton(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.red)),
              color: Colors.red.shade400,
              padding: EdgeInsets.fromLTRB(size.width * 0.1, size.height * 0.02,
                  size.width * 0.1, size.height * 0.02),
              onPressed: () {
                _subimit(context);
              }, // monVal == false ? null:   _subimit ,
              child: Text(
                'Cancelar Orden',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }

  _subimit(context) {
    final prefs = PreferenciasUsuario();

    Alert(
      context: context,
      title: "CONFIRMACIÓN",
      desc: "Estás  seguro de cancelar tu Orden?",
      buttons: [
        DialogButton(
          child: Text(
            "CANCELAR",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.red,
        ),
        DialogButton(
          child: Text(
            "ACEPTAR",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            final finishOrder = FinishOrderProvider();
            var res = finishOrder.finishOrder();
            res.then((response) async {
              if (response['response'] == 2) {
                prefs.order = '0';
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Services()));
              }
            });
          },
          color: Colors.green,
        ),
      ],
    ).show();
  }

  Widget _crearListado() {
    final temporalOrderProvider = TemporalOrderProvider();

    return FutureBuilder(
      future: temporalOrderProvider.getTemporalProvider(),
      builder: (BuildContext context,
          AsyncSnapshot<List<TemporalServices>> snapshot) {
        if (snapshot.hasData) {
          final productos = snapshot.data;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            key: UniqueKey(),
            itemCount: productos.length,
            itemBuilder: (context, i) => _crearItem(context, productos[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, TemporalServices producto) {
    final size = MediaQuery.of(context).size;

    return Container(
        child: Stack(children: <Widget>[
      Container(
        margin:
            EdgeInsets.only(left: size.width * 0.04, right: size.width * 0.04),
        child: Column(children: <Widget>[
          ListTile(
            title: Text('x' + ' ' + '${producto.quantity}',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0)),
            leading: Text('${producto.nameService}',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0)),
            trailing: Text("\$" + '${producto.price * producto.quantity}',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0)),
          ),
          Container(
              margin: const EdgeInsets.only(),
              child: Divider(
                color: Colors.black,
              )),
        ]),
      ),
    ]));
  }

  void _onButtonPressed(BuildContext context) {
    final size = MediaQuery.of(context).size.height;

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: size * 1,
            child: Container(
              child: EditOrder(),
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
