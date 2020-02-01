import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timugo/src/models/user_model.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'codeVerification_page.dart';
 

 
class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final  registeProvider = NumberProvider();
  
  bool monVal = false;
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
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: size.height*0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height:size.height*0.05),
                Text('Ingresa a Timugo con tu número celular', textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 20)
                      ),
                SizedBox(height:size.height*0.02),
                _numberLogin( context ),
            ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _numberLogin(BuildContext context){
    final size = MediaQuery.of(context).size;
    final userInfo   = Provider.of<UserInfo>(context);
    return Form(
          key: _formKey,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Container(
                  child:new Flexible(
                    child:CountryCodePicker(
                      onChanged: print,
                      initialSelection: 'CO',
                      favorite: ['+57','CO'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    ),
                  )
                ),
                new Container(
                  child:new Flexible(
                    child:MyTextFormField(
                      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                      hintText: 'Celular',
                      validator: (String value) {
                        if ( value.length < 10){
                          return 'Digita un numero valido';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        model.phone = int.parse(value);
                        userInfo.phone = model.phone;
                      },
                    )
                  ),
                )
              ]
            ),
            RaisedButton(                                   
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
                side: BorderSide(color: Colors.green)
              ),
              color: Colors.green.shade300,
              padding: EdgeInsets.fromLTRB(size.width*0.2, 20.0, size.width*0.2, 20.0),
              onPressed: monVal == false ? null:   _subimit ,
              child: Text(
                'Recibir código  por SMS',textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.white,
                ),
              ),
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: Text('Acepto recibir el código de verificación por SMS.',style: TextStyle(fontSize: 13)),
              value: monVal,
              onChanged: (bool value) {
                setState(() {
                  monVal = value;
                });
              },
            )
          ]
        )
    );
  }

   void _subimit(){
     print(model.phone);
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              var res= registeProvider.sendNumber(model);
              res.then((response) async {
               if (response['response'] == 2){
                 Navigator.push(
                   context,MaterialPageRoute(
                   builder: (context) => Code(model: this.model))
                );

               }else{

                 print( response['content']);
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

  MyTextFormField({
    this.text,
    this.hintText,
    this.validator,
    this.onSaved,
    this.inputFormatters
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
                        const Radius.circular(10.0),
                      ),),
                    border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                        const Radius.circular(10.0),
                      ),
              )
        ),
        validator: validator,
        onSaved: onSaved,
        inputFormatters: inputFormatters,
     
      ),
    );


    
  }
  
}

