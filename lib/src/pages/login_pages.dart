import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timugo/src/models/user_model.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';

import 'codeVerification_page.dart';
 

 
class LoginPage extends StatefulWidget {

 

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final  registeProvider = NumberProvider();
 
 
  Model model = Model();
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      body:Stack(
        children: <Widget>[
           Container(
      
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          // //    image: AssetImage('assets/images/timugo.png'),
          //     fit: BoxFit.fitWidth,
          //     alignment: Alignment.topCenter,
          //   //  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop)
          //   )
          // ),
        ),
        //  _crearFondo(context),
          _loginForm(context),
        ],
      ),
      
    );
  }

Widget _loginForm(BuildContext context) {

 // final size = MediaQuery.of(context).size;

  return SingleChildScrollView(
    child: Column(
      children: <Widget>[

       

         Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 270),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          
            
                
          child: Column(
            children: <Widget>[
              Text('Ingreso', textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)
                    ),
              SizedBox(height: 60.0),
              _numberLogin( context ),
              SizedBox(height: 30.0),
          
            ],
          ),
        ),
        GestureDetector(
          child: Text('Acepto de manera expresa e informada los Términos & Condiciones y la Política de Tratamiento de Datos Personales de Timugo S.A.S', style: TextStyle(decoration: TextDecoration.underline),),
          onTap: (){
         ///  Navigator.pushNamed(context, 'register');
          },
        ),
        SizedBox(height: 80.0,)
      ],
    ),
  );
}

Widget _numberLogin(BuildContext context){
   final userInfo   = Provider.of<UserInfo>(context);
    return Form(
      

     
        key: _formKey,
        child: Column(
          children: <Widget>[

              MyTextFormField(
                inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly],
                
            text: Icon(Icons.phone_android),
            hintText: 'Celular',
            validator: (String value) {
              if ( value.length < 10){
                return 'Digita un numero valido';
              }
              return null;
            },
            onSaved: (String value) {
              print('entre');
                      model.phone = int.parse(value);
                      userInfo.phone = model.phone;
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
                  print('lo recibio');
                  print( response['content']);
                  Navigator.push(
                   context,
                  
                   MaterialPageRoute(
                 builder: (context) => Code(model: this.model)));

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

