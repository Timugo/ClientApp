// //flutter dependencies
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'payments_page.dart';

// //pages
class NequiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<NequiPage>
    with SingleTickerProviderStateMixin {
  int _tabIndex = 0;
  TextEditingController cedulaController = new TextEditingController();
  TextEditingController numeroController = new TextEditingController();
  String token;
  bool uniquePay = false;
  bool automaticPay = false;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  void _toggleTab() {
    _tabIndex = _tabController.index + 1;
    _tabController.animateTo(_tabIndex);
  }

  void _backTab() {
    if (_tabIndex == 0) {
      Navigator.of(context).pop();
    } else {
      if (_tabIndex == 1) {
        setState(() {
          automaticPay = false;
          uniquePay = false;
        });
      }
      _tabIndex = _tabController.index - 1;
      _tabController.animateTo(_tabIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white12,
            elevation: 0,
            leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 35,
              ),
              onPressed: _backTab,
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('Elige un metodo de pago',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700)),
                    leading:
                        Image(image: AssetImage('assets/images/Nequi.png')),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          automaticPay = true;
                        });
                        _toggleTab();
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        margin: EdgeInsets.only(left: 40, right: 40, top: 5),
                        child: Column(children: <Widget>[
                          Container(
                              child: Image.network(
                            'https://nequi-wp-colombia.s3.amazonaws.com/conecta/s3fs-public/api3.png',
                            width: size.width,
                            height: size.height * 0.25,
                          )),
                          Container(
                              child: ListTile(
                                  title: Text('Pago con débito automático',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800)),
                                  subtitle: Text(
                                    "Se te harán cobros automaticos desde tu cuenta Nequi subscrita a timugo, cada vez que realices un servicio,solo basta con acepar la subscripción.",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300),
                                    maxLines: 4,
                                  )))
                        ]),
                      )),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          uniquePay = true;
                        });
                        _toggleTab();
                      },
                      child: Card(
                        margin: EdgeInsets.only(left: 40, right: 40, top: 5),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(children: <Widget>[
                          Container(
                              child: Image.network(
                            'https://nequi-wp-colombia.s3.amazonaws.com/conecta/s3fs-public/debito_automatico_ext_0.png',
                            width: size.width,
                            height: size.height * 0.25,
                          )),
                          Container(
                              child: ListTile(
                                  title: Text('Pagos únicos',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800)),
                                  subtitle: Text(
                                    "Con pagos únicos de Nequi tienes que aceptar el pago cada vez que realices un servicio.",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300),
                                    maxLines: 4,
                                  ))),
                        ]),
                      ))
                ],
              ),
              main(context),
              _verification(context),
            ],
          ),
        ));
  }

  Widget main(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/Nequi.png'),
                  width: 100,
                  height: 100,
                ),
                ListTile(
                  title: Text('Ahora debes agregar tu cuenta',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700)),
                  subtitle: Text(
                      'Recuerda agregar un numero asociado a una cuenta Nequi*',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w200)),
                )
              ]),
          _numberLogin(context),
          RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            color: Colors.green.shade300,
            padding: EdgeInsets.all(0.0),
            onPressed: () => _subimit(),
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
                      size.width * 0.35, 20.0, size.width * 0.35, 20.0),
                  child: Text(
                    'Agregar cuenta',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _numberLogin(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Form(
            key: _formKey,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MyTextFormField(
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    text: Icon(Icons.phone),
                    keyboardType: TextInputType.number,
                    hintText: 'Número de celular',
                    validator: (String value) {
                      if (value.length < 10) {
                        return 'Digita un numero valido';
                      }
                      return null;
                    },
                    controller: numeroController,
                  ),
                ])));
  }

  Widget _verification(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return loading
        ? _loading(context)
        : SingleChildScrollView(
            child: Column(children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/Nequi.png'),
                    width: 100,
                    height: 100,
                  ),
                  ListTile(
                    title: Text('Ahora solo falta verificar tu cuenta',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700)),
                    subtitle: Text(
                        'Recuerda que para pagos automaticos debes subscribirte*',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w200)),
                  )
                ]),
            RaisedButton(
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              color: Colors.green.shade300,
              padding: EdgeInsets.all(0.0),
              onPressed: () => _subimit2(token),
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
                        size.width * 0.35, 20.0, size.width * 0.35, 20.0),
                    child: Text(
                      'Verificar Cuenta',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            )
          ]));
  }

  Widget _loading(BuildContext context) {
    return Center(
        child: SpinKitRing(
      color: Colors.black12,
    ));
  }

  // response 2: content "message" ->  "description"  "token"-> guardarlo model.
  // vista   donde  infrome que debe acepar la subscripcion  -> Boton para comprobar la sub.
  // botton llama a  getSubscription con numero de nequi y el token. -> response == 2  y  "message" ACCEPTED REJECTED PENDING  then  uimprimo -> content " descrption" -> saveNequiOcount
  _showMessa(String mesg) {
    // show the toast message in bell appbar
    Fluttertoast.showToast(
      msg: mesg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0
    );

  }

  _subimit() {
    final nequiPaymentAutomatic = NequiPaymentAutomatic();
    if (_formKey.currentState.validate()) {
      if (automaticPay == true) {
        _formKey.currentState.save();
        var res = nequiPaymentAutomatic.nequiAutomatic(numeroController.text);
        res.then((response) async {
          if (response['response'] == 2) {
            if (response['content']['message'] == 'ACCEPTED') {
              _showMessa(response['content']['description']);
              setState(() {
                token = response['content']['token'];
              });
              _toggleTab();
            }
          }
        });
      }
      if (uniquePay == true) {
        _formKey.currentState.save();
        var res =
            nequiPaymentAutomatic.addNequiAcountUnique(numeroController.text);
        res.then((response) async {
          if (response['response'] == 2) {
            _showMessa('Se ha agregado exitosamente tu cuenta');
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Payment()));
          } else {
            _showMessa('Algo ha sucecido,intenta de nuevo');
          }
        });
      }
    }
    //  var resget= nequiPaymentAutomatic.getSubscription(numeroController.text,token);
    //           resget.then((response) async {
    //             if (response['response'] == 2){
    //               if( response['content']['message'] == 'ACCEPTED'){
    //                   _showMessa( response['content']['description']);
    //               }
    //             }
    //           });
  }

  void _finish() async {
    setState(() {
      loading = false;
    });
  }

  _subimit2(token) {
    final nequiPaymentAutomatic = NequiPaymentAutomatic();
    if (token != null) {
      var res =
          nequiPaymentAutomatic.addNequiAcount(numeroController.text, token);
      res.then((response) async {
        if (response['response'] == 2) {
          _showMessa('Se ha agregado exitosamente tu cuenta');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Payment()));
        } else {
          {
            setState(() {
              loading = true;
              _loading(context);
              new Future.delayed(new Duration(seconds: 3), _finish);
            });

            _showMessa(response['content']['message']);
          }
        }
      });
    }
  }
}

class MyTextFormField extends StatelessWidget {
  final Icon text;
  final String hintText;
  final Function validator;
  final Function onSaved;
  final List inputFormatters;
  final bool isEmail;
  final TextInputType keyboardType;
  final TextEditingController controller;

  MyTextFormField(
      {this.text,
      this.hintText,
      this.validator,
      this.onSaved,
      this.inputFormatters,
      this.isEmail = false,
      this.keyboardType,
      this.controller});

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
              borderSide: const BorderSide(color: Colors.white, width: 0.0),
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
        onSaved: onSaved,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        controller: controller,
      ),
    );
  }
}
