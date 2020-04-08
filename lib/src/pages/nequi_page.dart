//flutter dependencies


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timugo/src/pages/Payment.dart';
//user dependencies
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:provider/provider.dart';
//pages 

class NequiPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<NequiPage> {
  final _formKey = GlobalKey<FormState>();
  bool monVal = false;
  int cont =0;
  
   

  @override
  Widget build(BuildContext context) {
    
    return Scaffold( 
      backgroundColor: Colors.grey[100],
       
       appBar: AppBar(
      
         elevation: 0,
         leading: new IconButton(
               icon: new Icon(Icons.arrow_back, color: Colors.black,size: 35,),
               onPressed: () => Navigator.of(context).pop(),
         ),
        backgroundColor: Colors.grey[100],
       ),
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
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
            
            Text(
              'Nequi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              
              ),
            Image( image:AssetImage('assets/images/Nequi.png'),width: 100,height: 100,),
            
             ]),
          _numberLogin( context ),
            RaisedButton(
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
              ),
              color: Colors.green.shade300,
                padding: EdgeInsets.all(0.0),
              
              onPressed:(){



              },
              
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
                'Agregar',textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              )
                ),
              ),
      ),
        ],
      ),
    );
  }

  Widget _numberLogin(BuildContext context){
    final userInfo   = Provider.of<UserInfo>(context);
    final size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.all(30),
       shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
        ),
      elevation: 5,
      
     child:Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[   
              MyTextFormField(
                text: Icon(Icons.assignment_ind),
                hintText: 'Documento de identificación',
                keyboardType: TextInputType.number,
                validator: (String value) {
                  if ( value.isEmpty){
                    return 'Digita un nombre';
                  }
                  return null;
                },
                onSaved: (String value) {
                
                },
          
              ),
            MyTextFormField(
                      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                      text: Icon(Icons.phone),
                      keyboardType: TextInputType.number,
                      hintText: 'Número de celular',
                      validator: (String value) {
                        if ( value.length < 10){
                          return 'Digita un numero valido';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                      },
                    ),
           
            // CheckboxListTile(
            //   controlAffinity: ListTileControlAffinity.leading,
            //   title: InkWell(
            //   child: new Text('Acepto terminos y condiciones',style: TextStyle(fontSize: 13,color: Colors.blue,decoration: TextDecoration.underline)),
            //     onTap: ()  {  Navigator.push(context,
            //                     MaterialPageRoute(
            //                       builder: (context) => MyWebView()
            //                     )
            //                   );
            //                 }
            //   ),
            //   value: monVal,
            //   onChanged: (bool value) {
            //     setState(() {
            //       monVal = value;
            //       cont+=1;
            //       print(cont);
                  
            //     });
            //   },
            //   )
          ]
        )
    )
    )
    ;
  }
  
  // response 2: content "message" ->  "description"  "token"-> guardarlo model.
  // vista   donde  infrome que debe acepar la subscripcion  -> Boton para comprobar la sub.
  // botton llama a  getSubscription con numero de nequi y el token. -> response == 2  y  "message" ACCEPTED REJECTED PENDING  then  uimprimo -> content " descrption" -> saveNequiOcount
   _subimit(context){
    final userInfo   = Provider.of<UserInfo>(context);
    final prefs = new PreferenciasUsuario();
    
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // var res= sendDataProvider.sendData();
      
      // res.then((response) async {
      //   if (response['response'] == 2){
      //     print( response['content']);
      //     prefs.token=userInfo.phone.toString();
      //     Navigator.push(
      //       context,  
      //       MaterialPageRoute(
      //         builder: (context) => Services()
      //       )
      //     );

      //   }else{
      //     print( response['content']);
      //     _showMessa();
      //   }
      // });
    }                
  }
  
    _showMessa2(){ // show the toast message in bell appbar
    Fluttertoast.showToast(
      msg: "Por favor seleciona un  elemento*",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0
    );

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

  MyTextFormField({
    this.text,
    this.hintText,
    this.validator,
    this.onSaved,
    this.inputFormatters,
    this.isEmail = false,
    this.keyboardType
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
      keyboardType:keyboardType
      ),
    );
  }
}



