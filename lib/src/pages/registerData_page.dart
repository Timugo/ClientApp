import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timugo/src/models/user_model.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:validators/validators.dart' as validator;

 

 
class RegisterData extends StatefulWidget {

 

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterData> {
  final _formKey = GlobalKey<FormState>();
  final  sendDataProvider = SendDataProvider();
 
 
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
              Text('datos', textAlign: TextAlign.left,
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
        final userInfo   = Provider.of<UserInfo>(context);
        final prefs = new PreferenciasUsuario();

            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              var res= sendDataProvider.sendData(userInfo.phone,model.name,model.email);
             

              res.then((response) async {
                if (response['response'] == 2){
                  print('lo recibio');
                  print( response['content']);
                  prefs.token=userInfo.phone.toString();
                 
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
         keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,

      ),
    );


    
  }
  
}

