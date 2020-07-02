//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timugo/globals.dart' as globals;
import 'package:timugo/src/models/aditional_model.dart';
import 'package:timugo/src/models/order_model.dart';
import 'package:timugo/src/pages/homeservices/domain/services_model.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:timugo/src/widgets/appbar.dart';
import 'package:timugo/src/widgets/buttonCustom.dart';

import '../../checkout/checkout_page.dart';

// this class contains the  checkin and  aditional services of  services pages
class Checkin extends StatefulWidget {
  final ServicesModel model; //  this class receive  the model of services
  Checkin({this.model});
  @override
  _CheckinState createState() {
    return new _CheckinState(model: model);
  }
}

class _CheckinState extends State<Checkin> {
  final ServicesModel model;
  _CheckinState({this.model});

  final List orderFinal = []; // contains the final order
  final List temporalOrder = [];
  final order = OrderModel(); // instance  of order model
  List<int> individualCount = [
    0,
    0
  ]; // list that contains the quantity of each service

  int number = 1;
  int total = 0;
  int count = 0;

  // this function add the  principal service of user
  void addServiceToarray() {
    if (temporalOrder.contains(model.name)) {
      for (var i in orderFinal) {
        if (i["nameService"] == model.name) {
          i["quantity"] = number;
          print(orderFinal);
        }
      }
    } else {
      temporalOrder.add(model.name);
      order.id = model.id;
      order.nameService = model.name;
      order.typeService = "Service";
      order.price = model.price;
      order.quantity = number;
      orderFinal.add(order.toJson());
      print(orderFinal);
    }
  }

  // this function  decrease the  number of people that give the pricipal service
  void removeOrder(tot, key) {
    setState(() {
      if (total > 0 && tot != null) {
        total -= int.parse(tot);
        count--;
      }
    });
  }

  // this function increase the  number of people that give the pricipal service
  void addOrder(tot) {
    setState(() {
      if (count < number) {
        total += int.parse(tot);
        count++;
      }
    });
  }

  // this function  decrease the  number of  aditionals items  that has the pricipal service
  void subtractNumbers() {
    setState(() {
      if (number > 1) {
        number--;
      }
    });
  }
  // this function  increase the  number of  aditionals items  that has the pricipal service

  void addNumbers() {
    setState(() {
      number = number + 1;
    });
  }

  void increment(int index, AditionalModel producto) {
    setState(() {
      individualCount[index]++;
      total += int.parse(producto.price);
    });
  }

  void decrement(int index, AditionalModel producto) {
    setState(() {
      if (individualCount[index] > 0) {
        individualCount[index]--;
        total -= int.parse(producto.price);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Data server Url
    final String dataUrl = globals.dataUrl;
    final size = MediaQuery.of(context).size;
    final price = int.parse(model.price);

    return Scaffold(
        body: Stack(alignment: Alignment.topCenter, children: <Widget>[
      AppBarCheckin(),
      Positioned(
          top: 70,
          height: size.height * 0.25,
          child: Image.network(
            dataUrl + model.urlImg,
            width: size.height * 0.20,
          )),
      Container(
        child: _crearListado(),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: double.infinity,
          height: size.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: <Widget>[_buttonadd()],
              ),
              SizedBox(
                width: size.width * 0.07,
              ),
              Column(children: <Widget>[
                Container(
                    child: MyCustomButtoms(
                        hintText: 'Agregar' +
                            ' ' +
                            "\$" +
                            (total + price * (number)).toString(),
                        onPressed: () {
                          _submit(price);
                        },
                        colors: [
                      Color(0xFF19AEFF),
                      Color(0xFF139DF7),
                      Color(0xFF0A83EE),
                      Color(0xFF0570E5),
                      Color(0xFF0064E0)
                    ])),
              ])

              // )
            ],
          ),
        ),
      )
    ]));
  }

  void _submit(int price) {
    final userInfo = Provider.of<UserInfo>(context);

    userInfo.price = total.toString();
    addServiceToarray();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Checkout(
                temp: orderFinal, price: price * number, priceA: total)));
  }

// this  widget contains the add button
  Widget _buttonadd() {
    final size = MediaQuery.of(context).size;

    return Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new IconButton(
                padding: EdgeInsets.only(right: size.width * 0.04),
                icon: Icon(
                  Icons.remove,
                  size: 30,
                ),
                color: Colors.black,
                onPressed: subtractNumbers,
              ),
              Text(number.toString(),
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 30.0)),
              new IconButton(
                padding: EdgeInsets.only(left: size.width * 0.04),
                icon: Icon(
                  Icons.add,
                  size: 30,
                ),
                color: Colors.black,
                onPressed: addNumbers,
              ),
            ],
          )
        ],
      ),
    );
  }

  //this widget paint  call the aditional services provider and create a iterable list
  Widget _crearListado() {
    final aditionalProvider = AditionalProvider();
    final size = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.only(top: size.height * 0.35),
        child: Stack(children: <Widget>[
          Container(
              width: double.infinity,
              color: Colors.grey[300],
              height: size.height * 0.05,
              child: Center(
                child: new Text(
                  "Numero de personas" + ' ' + number.toString(),
                  textAlign: TextAlign.center,
                ),
              )),
          Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.05, bottom: size.height * 0.1),
              child: FutureBuilder(
                future: aditionalProvider.getAditional(model.id.toString()),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AditionalModel>> snapshot) {
                  if (snapshot.hasData) {
                    final productos = snapshot.data;
                    return ListView.builder(
                      key: UniqueKey(),
                      itemCount: productos.length,
                      itemBuilder: (context, i) => ListTileItem(
                        producto: productos[i],
                        count: individualCount[i],
                        decrement: () => decrement(i, productos[i]),
                        increment: () => increment(i, productos[i]),
                        addAditional: () => addAditionalOrder(productos[i]),
                        deleteAditional: () =>
                            deleteAditionalOrder(productos[i]),
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ))
        ]));
  }

  // this function add the  items the order to list as  json
  void addAditionalOrder(producto) {
    if (temporalOrder.contains(producto.name)) {
      //verify that the article is already added to the list
      for (var i in orderFinal) {
        if (i["nameService"] == producto.name) {
          i["quantity"] += 1;
          print('agrego');
          print(orderFinal);

          // just add if it's on the list
        }
      }
    } else {
      print('nuevo'); //if not added create the item
      temporalOrder.add(producto.name);
      order.id = producto.id;
      order.nameService = producto.name;
      order.typeService = "aditional";
      order.price = producto.price;
      order.quantity = 1;
      orderFinal.add(order.toJson());
      print(orderFinal);
      print(temporalOrder);
    }
  }

  // this function delete the  items the order to list as  json
  void deleteAditionalOrder(producto) {
    for (var i in orderFinal) {
      if (i["nameService"] == producto.name) {
        if (i["quantity"] == 1) {
          // if  te quantity of item is the  latest  the delte of list
          orderFinal.remove(i);
          temporalOrder.remove(producto.id);
        } else {
          i["quantity"] -= 1; // just drecrement if there is more than one item
        }
      }
    }
  }
}

class ListTileItem extends StatelessWidget {
  final AditionalModel producto;
  final int count;
  final Function decrement;
  final Function increment;
  final Function addAditional;
  final Function deleteAditional;

  ListTileItem(
      {this.producto,
      this.count,
      this.decrement,
      this.increment,
      this.addAditional,
      this.deleteAditional});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
        elevation: 4,
        margin: EdgeInsets.only(
            left: size.width * 0.06,
            right: size.width * 0.06,
            top: 15,
            bottom: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Stack(key: key, children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
            child: Row(children: <Widget>[
              Column(children: <Widget>[
                Text('${producto.name}',
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
                    count == 0
                        ? Container()
                        : IconButton(
                            icon: Icon(Icons.remove),
                            color: Colors.black,
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
                        color: Color(0xFF0064E0),
                        onPressed: () {
                          increment();
                          addAditional();
                        })
                  ])),
        ]));
  }
}
