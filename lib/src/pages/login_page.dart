import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timugo/src/models/user_model.dart';
import 'package:timugo/src/pages/registerData_page.dart';
import 'package:timugo/src/pages/services_page.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'codeVerification_page.dart';

import 'package:location_permissions/location_permissions.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final registeProvider = NumberProvider();

  bool monVal = false;
  Model model = Model();
  String _currentAddress;
  Position _currentPosition;


  Future<Position> _getCurrentLocation(context) async {
    final userInfo = Provider.of<UserInfo>(context);
    
  try {
     await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)

        
        .then((response) {
      setState(() {
        _currentPosition = response;
        userInfo.loca = _currentPosition;
        print('location');
        print(_currentPosition);
      });
      _getAddressFrom();
    });

  }
   catch (e) {
      print(e);
    }
   
    return _currentPosition;
  }

  Future<String> _getAddressFrom() async {
   
    try {
      List<Placemark> p = await Geolocator().placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress = "${place.subAdministrativeArea}";
        print(_currentAddress);
      });
    } catch (e) {
      print(e);
    }
    return _currentAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    _getCurrentLocation(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: size.height * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.05),
                Text('Ingresa a Timugo con tu número celular',
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: size.height * 0.02),
                _numberLogin(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _numberLogin(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userInfo = Provider.of<UserInfo>(context);
    return Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                        child: new Flexible(
                      child: CountryCodePicker(
                        countryFilter: ['CO'],
                        onChanged: print,
                        initialSelection: 'CO',
                        favorite: ['+57', 'CO'],
                        showCountryOnly: true,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                      ),
                    )),
                    new Container(
                      child: new Flexible(
                          child: MyTextFormField(
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        hintText: 'Celular',
                        validator: (String value) {
                          if (value.length < 10) {
                            return 'Digita un numero valido';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          model.phone = int.parse(value);
                          userInfo.phone = model.phone;
                        },
                      )),
                    )
                  ]),
              RaisedButton(
                elevation: 5.0,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                padding: EdgeInsets.all(0.0),
                onPressed: monVal == false ? null : _subimit,
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
                          size.width * 0.2, 20.0, size.width * 0.2, 20.0),
                      child: Text(
                        'Recibir código  por SMS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text('Acepto recibir el código de verificación por SMS.',
                    style: TextStyle(fontSize: 13)),
                value: monVal,
                onChanged: (bool value) {
                  setState(() {
                    monVal = value;
                  });
                },
              )
            ]));
  }

  _openSettings(context) {
    Alert(
        context: context,
        title: 'Ubicación',
        content: Column(
          children: <Widget>[
            Container(
              height: 200,
              color: Color(0xffeeeeee),
              padding: EdgeInsets.all(10.0),
              child: new Text(
                  'Es importante que actives tu GPS, Timugo no puede trabajar sin tu ubicación'),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              LocationPermissions().openAppSettings().then((bool hasOpened) =>
                  debugPrint('App Settings opened: ' + hasOpened.toString()));
            },
            child: Text(
              "Abrir Configuraciones",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  void _subimit() async {
    PermissionStatus permission =
        await LocationPermissions().requestPermissions();
    if (permission == PermissionStatus.denied) {
      _openSettings(context);
    }

    else{
    
    Future.delayed(const Duration(seconds: 1), () {

      _getCurrentLocation(context);
    });
    print(_currentAddress);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var res = registeProvider.sendNumber(model.phone, _currentAddress);
      res.then((response) async {
        print(response['content']);
        if (response['response'] == 2) {
          if (response['content']['code'] == 2) {
            if (response['content']['newUser'] == true) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterData()));
            } else {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Services()));
            }
          } else {
            print(model.phone);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Code(model: this.model)));
          }
        } else {
          print(response['content']);
        }
      });
    }
    }
  }
}

class MyTextFormField extends StatelessWidget {
  final Icon text;
  final String hintText;
  final Function validator;
  final Function onSaved;
  final List inputFormatters;
  final TextInputType keyboardType;

  MyTextFormField(
      {this.text,
      this.hintText,
      this.validator,
      this.onSaved,
      this.inputFormatters,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
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
          keyboardType: keyboardType),
    );
  }
}
