import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:timugo_client_app/models/dataClient_models.dart';
import 'package:timugo_client_app/providers/register_provider.dart';
import 'package:timugo_client_app/providers/sqlite_providers.dart';
import 'package:validators/validators.dart' as validator;
import 'model.dart';
import 'services_pages.dart';


class  Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   final appTitle = 'REGISTRATE';


    return MaterialApp(
      localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [ // English
          const Locale('es', 'ES'), // Spanish
    ],
     

      title: appTitle
      
      ,
      home: Scaffold(
        
        
      
        
        body: Stack(
          children: <Widget>[
            Container(
             child: _fondoApp(),
            ),
            Center(
              child:Container(
                child:TestForm(),
                )
            )

          ],
          

       
        )
      ),
    );
  }
}

class TestForm extends StatefulWidget {
  @override
  _TestFormState createState() => _TestFormState();
}

class _TestFormState extends State<TestForm> {
  DateTime _dateTime;
  final _formKey = GlobalKey<FormState>();
  final  registeProvider = RegisterProvider();
  Model model = Model();

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text('Registrate', textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 40)
                    ),
          Container(
            alignment: Alignment.topCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child: MyTextFormField(
                    text: Icon(Icons.people),
                    hintText: 'Nombre',
                    
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Digita tu nombre';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      model.firstName = value;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child: MyTextFormField(
                    hintText: 'Apellido',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Digita tu Apellido';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      model.lastName = value;
                    },
                  ),
                )
              ],
            ),
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
            },
          ),
           MyTextFormField(
            text: Icon(Icons.person_pin_circle),

            hintText: 'Direccion',
            validator: (String value) {
              if ( value.length < 10){
                return 'Digita direccion valida';
              }
              return null;
            },
            onSaved: (String value) {
              model.address = value;
            },
            ),
          MyTextFormField(
            text: Icon(Icons.phone_android),
            hintText: 'Celular',
            validator: (String value) {
              if ( value.length < 10){
                return 'Digita un numero valido';
              }
              return null;
            },
            onSaved: (String value) {
              model.phone = int.parse(value);
            },
          ),
           MyTextFormField(
            text: Icon(Icons.cake),
            hintText: (_dateTime == null ? 'Fecha de Nacimiento' : _dateTime.toString()),
            onTap:(){
               showDatePicker(
                  context: context,
                  initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2021),
                  locale : const Locale("es","ES"),
                  
                ).then((date) {
                  setState(() {
                    _dateTime = date;
                  });
                });
                

            

            },
            onSaved: (String value) {
              model.birth = _dateTime;
            },
          ),
          MyTextFormField(
            hintText: 'contraseña',
            text: Icon(Icons.vpn_key),
            isPassword: true,
            validator: (String value) {
              if (value.length < 7) {
                return 'La contraseña de tener minimo 7 caracteres';
              }

              _formKey.currentState.save();

              return null;
            },
            onSaved: (String value) {
              model.password = value;
            },
          ),
          MyTextFormField(
            hintText: 'Confirmar Contraseña',
            isPassword: true,
            validator: (String value) {
              if (value.length < 7) {
                return 'La contraseña de tener minimo 7 caracteres';
              } else if (model.password != null && value != model.password) {
              
                return 'La contraseñas no coinciden';
              }

              return null;
            },
          ),
          RaisedButton(
          
            color: Colors.blueAccent,
            onPressed: _subimit,
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
                
              ),
            ),
          )
        ],
      ),
    ),
    );

    
  }
   void _subimit(){
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              var res= registeProvider.createUser(model);
              res.then((response) async {
                if (response['response'] == 2){
                  await ClientDB.db.addClient(new DataClient(
                    id: response['content']['user']['id'],
                    name: response['content']['user']['name'],
                    lastName: response['content']['user']['lastName'],
                    address: response['content']['user']['address'],
                    email: response['content']['user']['email'],
                    birthdate: response['content']['user']['birthdate'],
                    phone: response['content']['user']['phone'],
                    token:response['content']['user']['token']
                  ));
                   Navigator.push(
                   context,
                  
                   MaterialPageRoute(
                 builder: (context) => Service()));
                 //    builder: (context) => Login()));


                }

              });

              
            }
              
           

              
   }
    Widget _birt(BuildContext context){
   return Scaffold(
    
         body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
       //     Text(_dateTime == null ? 'Nothing has been picked yet' : _dateTime.toString()),
            RaisedButton(
              child: Text('Pick a date'),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                  firstDate: DateTime(2001),
                  lastDate: DateTime(2021)
                ).then((date) {
                  setState(() {
                    _dateTime = date;
                  });
                });
              },
            )
          ],
        ),
      
    );





}
     
}

  Widget _fondoApp(){

    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.2),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            Color.fromRGBO(33, 72, 91, 1.0),
            Color.fromRGBO(255, 255, 255, 0.5)
          ]
        )
      ),
    );
    return Stack(
      children: <Widget>[
        gradiente
      ]
    );

  }

class MyTextFormField extends StatelessWidget {
  final Icon text;
  final String hintText;
  final Function validator;
  final Function onSaved;
  final Function onTap;
  final bool isPassword;
  final bool isEmail;

  MyTextFormField({
    this.text,
    this.hintText,
    this.validator,
    this.onSaved,
    this.onTap,
    this.isPassword = false,
    this.isEmail = false,
  });

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
              prefixIcon:text,


              enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 0.0),
                     borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),),
                    border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
              )
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        onTap: onTap,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );


    
  }
  
}



