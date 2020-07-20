//packages
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
// models
import 'package:timugo/src/models/order_model.dart';
import 'package:timugo/src/models/temporalOrder_model.dart';
//pages
import 'package:timugo/src/pages/orderinprocess/orderinprocces_page.dart';
import 'package:timugo/src/services/number_provider.dart';

class EditOrder extends StatefulWidget {
  @override
  _EditOrderState createState() {
    return new _EditOrderState();
  }
}

class _EditOrderState extends State<EditOrder> {
  final order = OrderModel();
  final List tem = [];
  final List orderFinal = [];
  int precio = 0;
  int totaOrder = 0;
  int total = 0;
  int count = 1;
  int add = 1; // count to add services to list
  List<int> individualCount = [0, 0, 0, 0, 0];
  void removeOrder(tot) {
    setState(() {
      if (total > 0) {
        total -= tot;
        if (total < 0) {
          total = 0;
        }
        count--;
      }
    });
  }

  void addOrder(tot) {
    setState(() {
      total += tot;
      count++;
    });
  }

  void increment(int index, TemporalServices producto) {
    setState(() {
      individualCount[index]++;
      total += (producto.price);
    });
  }

  void decrement(int index, TemporalServices producto) {
    setState(() {
      if (total > 0 && individualCount[index] > producto.quantity) {
        individualCount[index]--;
        total -= (producto.price);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _totalOrder();

    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: size.height * 0.01),
          child: _buttonadd()),
      Container(
          padding: EdgeInsets.only(
              top: size.height * 0.01, bottom: size.height * 0.08),
          alignment: Alignment.bottomCenter,
          child: _createEdit()),
    ]));
  }

  Widget _buttonadd() {
    final size = MediaQuery.of(context).size;
    print(orderFinal);
    return Container(
        padding: EdgeInsets.only(bottom: 30),
        child: RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20.0),
          ),
          color: Color(0xFF0570E5),
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
                padding: EdgeInsets.fromLTRB(size.width * 0.1,
                    size.height * 0.02, size.width * 0.1, size.height * 0.02),
                child: Text(
                  'Enviar Orden' + ' ' + "\$" + (total + totaOrder).toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
          ),

          onPressed: () {
            _subimit(context);
          }, // monVal == false ? null:   _subimit ,
        ));
  }

  _subimit(context) {
    Alert(
      context: context,
      title: "CONFIRMACIÓN",
      desc: "Estás  seguro de editar tu Orden?",
      buttons: [
        DialogButton(
          child: Text(
            "ACEPTAR",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            print(orderFinal);
            final editOrderProvider = EditOrderProvider();
            var res = editOrderProvider.editOrderProvider(orderFinal);
            res.then((response) async {
              if (response['response'] == 2) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderProcces()));
              }
            });
          },
          color: Colors.blue,
        ),
        DialogButton(
          child: Text(
            "CANCELAR",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.red,
        )
      ],
    ).show();
  }

  Widget _createEdit() {
    final temporalOrderProvider = TemporalOrderProvider();

    // final size = MediaQuery.of(context).size;

    return Stack(children: <Widget>[
      Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: 20),
        child: Text('Editar Orden Actual',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
      ),
      FutureBuilder(
        future: temporalOrderProvider.getTemporalProvider(),
        builder: (BuildContext context,
            AsyncSnapshot<List<TemporalServices>> snapshot) {
          if (snapshot.hasData) {
            final productos = snapshot.data;

            return ListView.builder(
              padding: EdgeInsets.only(top: 40),
              scrollDirection: Axis.vertical,
              key: UniqueKey(),
              itemCount: productos.length,
              itemBuilder: (context, i) => ListTileItem(
                producto: productos[i],
                count: individualCount[i],
                decrement: () => decrement(i, productos[i]),
                increment: () => increment(i, productos[i]),
                addAditional: () => addAditionalOrder(productos[i]),
                deleteAditional: () => deleteAditionalOrder(productos[i]),
                itemC: productos.length,
                add: add,
                addUnique: () => addUnique(productos[i], i),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    ]);
  }

  void addAditionalOrder(producto) {
    if (tem.contains(producto.nameService)) {
      for (var i in orderFinal) {
        if (i["nameService"] == producto.nameService) {
          i["quantity"] += 1;
          precio += int.parse(i["price"]);
        }
      }
    }
  }

  void deleteAditionalOrder(producto) {
    for (var i in orderFinal) {
      if (i["nameService"] == producto.nameService) {
        if (i["quantity"] > producto.quantity) {
          i["quantity"] -= 1;
          precio -= int.parse(i["price"]);
        } else {}
      }
    }
  }

  void addUnique(producto, i) {
    tem.add(producto.nameService);
    order.id = producto.id;
    order.nameService = producto.nameService;
    order.typeService = "aditional";
    order.price = producto.price.toString();
    order.quantity = producto.quantity;
    orderFinal.add(order.toJson());
    add += 1;
    individualCount[i] = producto.quantity;
  }

  _totalOrder() {
    final temporalOrderProvider = TemporalOrderProvider();
    var res = temporalOrderProvider.getBarberAsigned();
    res.then((response) async {
      totaOrder = response['content']['order']['price'];
      print(totaOrder);
    });

    return totaOrder;
  }
}

class ListTileItem extends StatelessWidget {
  final TemporalServices producto;
  final int count;
  final int itemC;
  final int add;
  final Function decrement;
  final Function increment;
  final Function addAditional;
  final Function deleteAditional;
  final Function addUnique;

  ListTileItem(
      {this.producto,
      this.count,
      this.decrement,
      this.increment,
      this.addAditional,
      this.deleteAditional,
      this.itemC,
      this.add,
      this.addUnique});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (add <= itemC) {
      addUnique();
    }
    return Container(
        margin: EdgeInsets.only(
            left: size.width * 0.04,
            right: size.width * 0.04,
            top: size.width * 0.1),
        child: Stack(key: key, children: <Widget>[
          Container(
            child: Row(children: <Widget>[
              Column(children: <Widget>[
                Text('${producto.nameService}',
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 18.0)),
                Text('+' + ' ' + "\$" + '${producto.price}',
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 15.0)),
              ]),
            ]),
          ),
          Padding(
              padding: EdgeInsets.only(),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.remove),
                        color: Colors.green,
                        onPressed: () {
                          decrement();
                          deleteAditional();
                        }),
                    Container(
                      padding:
                          const EdgeInsets.only(bottom: 2, right: 12, left: 12),
                      child: Text('$count'),
                    ),
                    IconButton(
                        key: key,
                        icon: Icon(
                          Icons.add,
                          size: 24,
                        ),
                        color: Colors.green,
                        onPressed: () {
                          increment();
                          addAditional();
                        })
                  ])),
          Container(
              margin: EdgeInsets.only(
                  left: size.width * 0.02,
                  right: size.width * 0.02,
                  top: size.width * 0.1),
              child: Divider(
                color: Colors.black,
                height: 36,
              )),
        ]));
  }
}
