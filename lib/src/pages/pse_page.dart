

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:timugo/src/models/pseInstitu_model.dart';
import 'package:timugo/src/pages/publicity_page.dart';
//user dependencies
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:provider/provider.dart';
import 'package:timugo/src/models/user_model.dart';
//pages 
import 'package:timugo/src/pages/services_page.dart';

class PSEpayment extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<PSEpayment> {
  final _formKey = GlobalKey<FormState>();
  final  sendDataProvider = SendDataProvider();
  final sendToken = TokenProvider();
  String idNumber;
  bool monVal = false;
  int cont =0;
  Model model = Model();
  static List<PersonModel> personItems = new List();
  static List<IdenTModel> identItems = new List();
  static List<InstituPse>  pseItems = new List();
  final formKey = new GlobalKey<FormState>();

  
  PersonModel _dropdownValue;
  IdenTModel _identValue;
  InstituPse _pseValue;
  
 
  TextEditingController codeController = new TextEditingController();
   TextEditingController typeController = new TextEditingController();
   TextEditingController instiController = new TextEditingController();
    final servicesProvider = GetPseInst();

  @override
  void initState() {
    identItems=[];
   personItems=[];
    super.initState();
    servicesProvider.getInstiPse().then((list){
      setState(() {
    pseItems = list;
  });

    });
    setState(() {
      personItems.add(PersonModel(person: 'Natural', code: '0'));
      personItems.add(PersonModel(person: 'Juridica', code: '1'));
      identItems.add(IdenTModel( code: '0',idType: 'CEDULA'));
      identItems.add(IdenTModel( code: '1',idType: 'NIT'));
       _dropdownValue = personItems[0];
       _identValue = identItems[0];
      codeController.text = _dropdownValue.code;
      typeController.text = _identValue.code;
    });
  }
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
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Ingresa tus datos',
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
    final size = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: Column(
         
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[   
            Card(
            child:ListTile(
              contentPadding: EdgeInsets.only(left:50,right:50),
              leading:  Icon(Icons.people),
              title: Text('Tipo de Persona'),
              trailing: DropdownButton<PersonModel>(
              value: _dropdownValue,
              isDense: true,
              onChanged: (PersonModel newValue) {
                print('value change');
                print(newValue);
                setState(() {
                  _dropdownValue = newValue;
                  codeController.text = _dropdownValue.code;
                });
              },
              items: personItems.map((PersonModel value) {
                return DropdownMenuItem<PersonModel>(
                  value: value,
                  child: Text(value.person),
                );
              }).toList(), 
              )
            )
            ),
             Card(
               child: ListTile(
                 contentPadding: EdgeInsets.only(left:50,right:50),
                leading: Icon(Icons.perm_identity),
                title: Text('identificación'),
                trailing: DropdownButton<IdenTModel>(
              value: _identValue,
              isDense: true,
              onChanged: (IdenTModel newValue) {
                print('value change');
                print(newValue);
                setState(() {
                  _identValue = newValue;
                  typeController.text = _identValue.idType;
                });
              },
              items: identItems.map((IdenTModel value) {
                return DropdownMenuItem<IdenTModel>(
                  value: value,
                  child: Text(value.idType),
                );
              }).toList(), 
              )

              
              
      
        )),
        Card(
          child:   MyTextFormField(
                text: Icon(Icons.people),
                keyboardType: TextInputType.number,
                hintText: 'Numero de identifcación',
                validator: (String value) {
                  if ( value.isEmpty){
                    return 'Digita un nombre';
                  }
                  return null;
                },
                onSaved: (String value) {
                 setState(() {
                   idNumber= value;
                 });
                },
          
              )),
              Card( 
                child:ListTile(
                    contentPadding: EdgeInsets.only(left:50,right:50),
                    leading: Icon(FontAwesomeIcons.university),
                    title: Text('Banco'),
                    trailing: DropdownButton<InstituPse>(
                  value: _pseValue,
                  isDense: true,
                  onChanged: (InstituPse newValue) {
                    print('value change');
                    print(newValue);
                    setState(() {
                      _pseValue = newValue;
                      instiController.text = _pseValue.code;
                    });
                  },
                  items: pseItems.map((InstituPse value) {
                    return DropdownMenuItem<InstituPse>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(), 
                  ) 
                )
              ),
           
            RaisedButton(
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
              ),
              color: Colors.green.shade300,
               padding: EdgeInsets.all(0.0),
             
              onPressed: monVal == false && cont < 2? null:() {  _sendCommet(context);},
              
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
                'Enviar',textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              )
                ),
              ),
            ),
           
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
        }
        else{
          print( response['content']);
          _showMessa();
        }
      });
    }                
  }
   _showMessa(){ // show the toast message in bell appbar
    Fluttertoast.showToast(
      msg: "El email tiene que ser único!",
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
  final TextInputType keyboardType;
  final bool isEmail;

  MyTextFormField({
    this.text,
    this.hintText,
    this.validator,
    this.onSaved,
    this.keyboardType,
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
      
      keyboardType:keyboardType ,
      ),
    );
  }
}



class PersonModel {
  String person = '';
  String code = '';
  String idType ='';

  PersonModel({
    this.person,
    this.code,
    this.idType
  });
}

class IdenTModel {
 
  String code = '';
  String idType ='';

  IdenTModel({
    this.code,
    this.idType
  });
}