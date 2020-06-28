//flutter dependencies


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timugo/src/pages/publicity_page.dart';
//user dependencies
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:validators/validators.dart' as validator; 
import 'package:provider/provider.dart';
import 'package:timugo/src/models/user_model.dart';
//pages 
import 'package:timugo/src/pages/services_page.dart';
import 'package:timugo/src/pages/webview_page.dart';

class RegisterData extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterData> {
  final _formKey = GlobalKey<FormState>();
  final  sendDataProvider = SendDataProvider();
  final sendToken = TokenProvider();
  bool monVal = false;
  int cont =0;
  Model model = Model();
   

  @override
  Widget build(BuildContext context) {
    
    return Scaffold( 
      body:Stack(
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

        
            SizedBox(height: size.height*0.1),
            Container(),
                SizedBox(height: 10),
                // Image.asset(
                //   'assets/verify.png',
                //   height: MediaQuery.of(context).size.height / 3,
                //   fit: BoxFit.fitHeight,
                // ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Datos Personales',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    textAlign: TextAlign.center,
                  ),
                ),
                _numberLogin( context )
        ],
      ),
    );
  }

  Widget _numberLogin(BuildContext context){
    final userInfo   = Provider.of<UserInfo>(context);
    final size = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[   
              MyTextFormField(
                text: Icon(Icons.people),
                hintText: 'Nombre',
                validator: (String value) {
                  if ( value.isEmpty){
                    return 'Digita un nombre';
                  }
                  return null;
                },
                onSaved: (String value) {
                  print('entre');
                  model.name = (value);
                  userInfo.name = model.name;
                   cont+=1;
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
                userInfo.email =model.email;
                cont+=1;
              },
            ),
            RaisedButton(
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
              ),
              color: Colors.green.shade300,
               padding: EdgeInsets.all(0.0),
             
              onPressed: monVal == true && cont <= 2? () {  _sendCommet(context);}:null,
              
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color(0xFF19AEFF), Color(0xFF139DF7),Color(0xFF0A83EE),Color(0xFF0570E5),Color(0xFF0064E0)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(20.0)
                ),
                child:Container(
                   padding: EdgeInsets.fromLTRB(size.width*0.35, 20.0, size.width*0.35, 20.0),
                  child:Text(
                'Entrar',textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              )
                ),
              ),
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: InkWell(
              child: new Text('Acepto terminos y condiciones',style: TextStyle(fontSize: 13,color: Colors.blue,decoration: TextDecoration.underline)),
                onTap: ()  {  Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (context) => MyWebView()
                                )
                              );
                            }
              ),
              value: monVal,
              onChanged: (bool value) {
                setState(() {
                  monVal = value;
                  cont+=1;
                  print(cont);
                  
                });
              },
              )
          ]
        )
    );
  }
  
  
   _subimit(context){
    final userInfo   = Provider.of<UserInfo>(context);
    final prefs = new PreferenciasUsuario();
    
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var res= sendDataProvider.sendData(userInfo.phone,model.name,model.email,userInfo.publi);
      sendToken.sendToken(prefs.token,prefs.tokenPhone.toString());
      
      res.then((response) async {
        if (response['response'] == 2){
          print('lo recibio');
          print( response['content']);
          prefs.token=userInfo.phone.toString();
          Navigator.push(
            context,  
            MaterialPageRoute(
              builder: (context) => Services()
            )
          );

        }else{
          print( response['content']);
          _showMessa("El email tiene que ser único!");
        }
      });
    }_showMessa("Por Favor complete los campos del formulario");                
  }
   _showMessa( String msg){ // show the toast message in bell appbar
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0
    );

  }
    _showMessa2(){ // show the toast message in bell appbar
    Fluttertoast.showToast(
      msg: "Por favor seleciona un  elemento*",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0
    );

  }
  
_sendCommet(context){
    final userInfo   = Provider.of<UserInfo>(context);
    print(userInfo.publi);
 Alert(
        context: context,
        title: "Cómo nos conociste?",
        content: Publicity(),
        buttons: [
          DialogButton(
            onPressed:  (){
              if (userInfo.publi == 'null'){
                _showMessa2();

              }
            else{_subimit(context);}
            },
            child: Text(
              "Enviar",
              style: TextStyle(color:  Colors.white, fontSize: 20),
            ),
          )
        ]).show();

}

}

class MyTextFormField extends StatelessWidget {
  final Icon text;
  final String hintText;
  final Function validator;
  final Function onSaved;
  final List inputFormatters;
  final bool isEmail;

  MyTextFormField({
    this.text,
    this.hintText,
    this.validator,
    this.onSaved,
    this.inputFormatters,
    this.isEmail = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left:size.width*0.1,right: size.width*0.1,bottom:10,top: size.width*0.05),
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
                        const Radius.circular(10.0),
                      ),
              ),
              border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                    ),
              )
      ),
      validator: validator,
      onSaved: onSaved,
      inputFormatters: inputFormatters,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      ),
    );
  }
}



