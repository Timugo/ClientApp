import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:credit_card_type_detector/credit_card_type_detector.dart';

class CreditCardH extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MySampleState();
  }
}

class MySampleState extends State<CreditCardH> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = 'Titular';
  String name;
  String lastName;
  String cvvCode = '';
  bool isCvvFocused = false;
  var type;
  var brand;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
          backgroundColor: Colors.white12,
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: Container(
          child: Column(
            children: <Widget>[
              Text(
                'Añadir tarjeta ',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 20),
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                cardBgColor: Colors.lightBlueAccent[700],
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        MyTextFormField(
                          hintText: "Numero de tarjeta",
                          onChanged: (value) {
                            setState(() {
                              cardNumber = value;
                              type = detectCCType(cardNumber);
                            });
                          },
                          keyboardType: TextInputType.number,

                          // _checkCard,
                        ),
                        MyTextFormField(
                          hintText: "Expiración tarjeta",
                          len: 4,
                          onChanged: (value) {
                            setState(() {
                              expiryDate = value;
                            });
                          },
                          keyboardType: TextInputType.number,
                        ),
                        Container(
                            child: Row(
                          children: <Widget>[
                            Flexible(
                                child: MyTextFormField(
                              hintText: "Nombre ",
                              onChanged: (value) {
                                setState(() {
                                  name = value + '';
                                  cardHolderName = name + lastName;

                                  isCvvFocused = false;
                                });
                              },
                            )),
                            Flexible(
                                child: MyTextFormField(
                              hintText: "Apellido",
                              onChanged: (value) {
                                setState(() {
                                  lastName = value;
                                  cardHolderName = name + lastName;

                                  isCvvFocused = false;
                                });
                              },
                            )),
                          ],
                        )),
                        MyTextFormField(
                          len: 3,
                          hintText: 'CVV',
                          onChanged: (value) {
                            setState(() {
                              cvvCode = value;
                              isCvvFocused = true;
                            });
                          },
                          keyboardType: TextInputType.number,
                          onComplete: () {
                            setState(() {
                              isCvvFocused = false;
                            });
                          },
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text(
                        'Por seguridad te cobraremos un monto menor a 500 para verificar que tu tarjeta sea valida.',
                        maxLines: 3,
                        style: TextStyle(fontSize: 15),
                      ),
                      leading: Icon(
                        Icons.security,
                        color: Colors.green,
                      ),
                    ),
                    RaisedButton(
                      elevation: 5.0,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: Colors.green.shade300,
                      padding: EdgeInsets.all(0.0),
                      onPressed: (){},
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
                            padding: EdgeInsets.fromLTRB(size.width * 0.35,
                                20.0, size.width * 0.35, 20.0),
                            child: Text(
                              'Añadir tarjeta',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                )),
              )
            ],
          ),
        )),
      ),
    );
  
//  _showMessa(String mesg){ // show the toast message in bell appbar
//     Fluttertoast.showToast(
//       msg: mesg,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//       fontSize: 14.0
//     );

//   _showMessa(String mesg) {
//     // show the toast message in bell appbar
//     Fluttertoast.showToast(
//         msg: mesg,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 14.0);
//   }

  // _sendCard() {
  //   final sendCreditCard = SendCreditCard();
  //   var res = sendCreditCard.sendCard(
  //       name,
  //       lastName,
  //       int.parse((expiryDate.substring(0, 2))),
  //       int.parse((expiryDate.substring(2, 4))),
  //       int.parse(cvvCode),
  //       brand,
  //       int.parse(cardNumber));

  //   res.then((response) async {
  //     print(response);
  //     if (response['response'] == 2) {
  //       _showMessa('Se ha agregado exitosamente tu cuenta');
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => Payment()));
  //     }
  //   });
  // }
 }
//  bool _checkCard(){
//    bool res = true;
//    if (type == CreditCardType.visa){
//       setState(() {
//         brand = 'VISA';
//       });
//    }
//    else if (type == CreditCardType.amex){
//       setState(() {
//         brand = 'AMERICAN_EXPRESS';
//       });
//    }
//    else if (type == CreditCardType.mastercard) {
//        setState(() {
//         brand = 'MASTER_CARD';
//       });
//    }

//    else {
//       _showMessa('Tarjeta no aceptada');
//       res = false;

//    }
//    return res;

//  }
}

class MyTextFormField extends StatelessWidget {
  final Icon text;
  final String hintText;
  final Function validator;
  final Function onChanged;
  final List inputFormatters;
  final bool isEmail;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function onComplete;
  final int len;

  MyTextFormField(
      {this.text,
      this.hintText,
      this.validator,
      this.onChanged,
      this.inputFormatters,
      this.isEmail = false,
      this.keyboardType,
      this.controller,
      this.len,
      this.onComplete});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.1,
          right: size.width * 0.1,
          bottom: 10,
          top: size.width * 0.05),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            prefixIcon: text,
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 0.0),
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            )),
        validator: validator,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        controller: controller,
        maxLength: len,
        onEditingComplete: onComplete,
      ),
    );
  }
}
