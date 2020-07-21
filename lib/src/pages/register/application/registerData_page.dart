//flutter dependencies
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
import 'package:validators/validators.dart' as validator;

/* Page for register the user Data (only  for register with  phone)*/
class RegisterUserData extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterUserData> {
  final _formKey = GlobalKey<FormState>();
  final sendDataProvider = LoginServices();
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
              child: Column(children: <Widget>[
                userInfo.registerMethod == "PHONE" ?
                  formUserData(context) : _numberForm(context),
                   MyCustomButtoms(
                hintText: "              Entrar",
                icon: FontAwesomeIcons.signInAlt,
                colors: [
                  Color(0xFF19AEFF),
                  Color(0xFF139DF7),
                  Color(0xFF0A83EE),
                  Color(0xFF0570E5),
                  Color(0xFF0064E0)
                ],
                onPressed: (){sendCommet(context,userInfo.name,userInfo.email,userInfo.registerMethod,userInfo.publi);},
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
        child: Column(
            
            
            children: <Widget>[
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
                    return 'Digita un nombre';
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
                  )
                ),
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
                          return 'Digita un número de teléfono valido';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        userInfo.phone= int.parse(value);
                      },
                    )
                  ),
                ),
               
              ]

            ),
          ]
        )
      )
     
    );
  }

  _subimit(context,String name, String email ,String method, String  publicity) {
    final userInfo = Provider.of<UserInfo>(context);
    final prefs = new PreferenciasUsuario();

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var res = sendDataProvider.singUp(prefs.token,name,email,method,publicity);
      sendToken.sendToken(prefs.token, prefs.tokenPhone.toString());

      res.then((response) async {
        if (response['response'] == 2) {
          print('lo recibio');
          print(response['content']);
          prefs.token = userInfo.phone.toString();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Services()));
        } else {
          print(response['content']);
          showToast("El email tiene que ser único!", Colors.red);
        }
      });
    }else{
      showToast("Por Favor complete los campos del formulario", Colors.red);
    }
    
  }

  sendCommet(context,String name, String email ,String method, String  publicity) {
    final userInfo = Provider.of<UserInfo>(context);
    if(_formKey.currentState.validate()){
    Alert(
        context: context,
        title: "Cómo nos conociste?",
        content: PublicityMethods(),
        buttons: [
          DialogButton(
            onPressed: () {
              if (userInfo.publi == 'null') {
                showToast("Por favor seleciona un  elemento*", Colors.red);
              } else {
                _subimit(context,name,email,method,publicity);
              }
            },
            child: Text(
              "Enviar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
    }
  }
}

