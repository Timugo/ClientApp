//flutter dependencies
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timugo/src/interfaces/server_response.dart';
import 'package:validators/validators.dart' as validator;
/* Models*/
import 'package:timugo/src/pages/Login/domain/user_model.dart';
import 'package:timugo/src/pages/Login/infrastructure/login_services.dart';
/* Pages */
import 'package:timugo/src/pages/homeservices/application/services_page.dart';
import 'package:timugo/src/pages/register/application/widgets/publicitymethods_widget.dart';
/* Provider*/
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/providers/user.dart';
/* services*/
import 'package:timugo/src/services/number_provider.dart';
/* Widgets*/
import 'package:timugo/src/widgets/buttonCustom.dart';
import 'package:timugo/src/widgets/textFormFieldCustom.dart';
import 'package:timugo/src/widgets/toastMessage.dart';

/* Page for register the user Data (only  for register with  phone)*/
class RegisterUserData extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterUserData> {
  final _formKey = GlobalKey<FormState>();
  final loginServices = LoginServices();
  final sendToken = TokenProvider();
  int cont = 0;
  UserModel model = UserModel();

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(size.height * 0.05),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              userInfo.registerMethod == "PHONE"
              ? formUserData(context)
              : _numberForm(context),
              MyCustomButtoms(
                hintText: "Entrar",
                icon: FontAwesomeIcons.signInAlt,
                colors: [
                  Color(0xFF19AEFF),
                  Color(0xFF139DF7),
                  Color(0xFF0A83EE),
                  Color(0xFF0570E5),
                  Color(0xFF0064E0)
                ],
                onPressed: () {
                  _publicityAlert(context);
                },
              )
            ]
          )
        )
      ),
    );
  }

  /* Contains  the form for the user data */
  Widget formUserData(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Text(
            'Datos Personales',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            textAlign: TextAlign.center,
          ),
          MyTextFormField(
            text: Icon(Icons.people),
            hintText: 'Nombre',
            validator: (String value) {
              if (value.isEmpty) {
                return 'Digita tu nombre';
              }
              return null;
            },
            onSaved: (String value) {
              model.name = (value);
              userInfo.name = model.name;
              cont += 1;
            },
          ),
          MyTextFormField(
            hintText: 'Correo',
            isEmail: true,
            text: Icon(Icons.email),
            validator: (String value) {
              if (!validator.isEmail(value)) {
                return 'Digita tu correo';
              }
              return null;
            },
            onSaved: (String value) {
              model.email = value;
              userInfo.email = model.email;
              cont += 1;
            },
          ),
          SizedBox(height: 20),
        ]));
  }

  Widget _numberForm(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);
    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                              child: TextFormField(
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Celular',
                            ),
                            validator: (String value) {
                              if (value.length < 10) {
                                return 'Minimo 10 numeros';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              userInfo.phone = int.parse(value);
                            },
                          )),
                        ),
                      ]),
                ])));
  }

  _publicityAlert(context) {
    final userInfo = Provider.of<UserInfo>(context);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Alert(
        context: context,
        title: "¿Cómo nos conociste?",
        content: PublicityMethods(),
        buttons: [
          DialogButton(
            onPressed: () {
              // If the user has no select a publicity option
              if (userInfo.publicityMethod == null ) {
                showToast("Ups... selecciona una opcion para continuar", Color(0xFF0570E5));
              } else {
                _submitRegisterForm(context);
              }
            },
            child: Text(
              "Registrarme",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]
      ).show();
    } else {
      showToast("Por Favor completa todos los campos", Colors.red);
    }
  }

  _submitRegisterForm(context) {
    final userInfo = Provider.of<UserInfo>(context);
    final prefs = new PreferenciasUsuario();
    print(prefs.token+userInfo.name+userInfo.email+userInfo.registerMethod+userInfo.publicityMethod);  
    loginServices.singUp(prefs.token, userInfo.name, userInfo.email, userInfo.registerMethod, userInfo.publicityMethod)
      .then((response) {
        print("Llego a este punto");
        // Map the answer
        final loginResponse = iServerResponseFromJson(response.body);
        //Successful login
        if (loginResponse.response == 2) {
          print(loginResponse.content);
          prefs.token = userInfo.phone.toString();
          // Register the phone token
          sendToken.sendToken(prefs.token, prefs.tokenPhone.toString());
          // Redirect to Services Page
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => Services())
          );
        } else {
          showToast("Ese email ya esta en uso, prueba con otro", Colors.red);
        }
      })
      .catchError((onError){
        showToast("Ups... tenemos un error. Estamos solucionandolo", Colors.red);
      });
  }

  
}
