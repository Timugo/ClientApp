//flutter dependencies
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timugo/src/pages/Login/domain/user_model.dart';
import 'package:timugo/src/pages/register/application/widgets/publicitymethods_widget.dart';
//user dependencies
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:timugo/src/widgets/buttonCustom.dart';
import 'package:timugo/src/widgets/textFormFieldCustom.dart';

// widgets
import 'package:timugo/src/widgets/toastMessage.dart';
import 'package:validators/validators.dart' as validator;
import 'package:provider/provider.dart';
//pages
import 'package:timugo/src/pages/homeservices/services_page.dart';

/* Page for register the user Data (only  for register with  phone)*/
class RegisterUserData extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterUserData> {
  final _formKey = GlobalKey<FormState>();
  final sendDataProvider = SendDataProvider();
  final sendToken = TokenProvider();
  int cont = 0;
  UserModel model = UserModel();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(size.height * 0.05),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
                  formUserData(context)
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  print('entre');
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
              MyCustomButtoms(
                hintText: "Entrar",
                colors: [
                  Color(0xFF19AEFF),
                  Color(0xFF139DF7),
                  Color(0xFF0A83EE),
                  Color(0xFF0570E5),
                  Color(0xFF0064E0)
                ],
                onPressed: (){sendCommet(context);},
              ),
            ]));
  }

  _subimit(context) {
    final userInfo = Provider.of<UserInfo>(context);
    final prefs = new PreferenciasUsuario();

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var res = sendDataProvider.sendData(
          userInfo.phone, model.name, model.email, userInfo.publi);
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

  sendCommet(context) {
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
                _subimit(context);
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

