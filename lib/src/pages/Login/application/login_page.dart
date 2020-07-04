/* Flutter dependencies */
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
/* Pages */
import 'package:timugo/src/pages/Login/application/widgets/privacypolicies_widget.dart';
import 'package:timugo/src/pages/Login/infrastructure/login_services.dart';
import 'package:timugo/src/pages/register/application/registerData_page.dart';
import 'package:timugo/src/providers/user.dart';
/* Widget */
import 'package:timugo/src/widgets/buttonCustom.dart';
import 'package:timugo/src/widgets/toastMessage.dart';
/* Models */
import '../domain/user_model.dart';


//contains the login page
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // key for validate the form number
  final _formKey = GlobalKey<FormState>();
  //  call to service to register
  final registeProvider = LoginServices();
  // check the policies privacity
  bool checkPolicies = false;
  // instace of Usermodel
  UserModel model = UserModel();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top:size.height * 0.05,left:size.height * 0.02,right:size.height * 0.02),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
            _loginImage(context),
            _numberForm(context),
            _stackButtons(context)
            ]
          )
        )
      ),
    );
  }
  // widget that paint the top image in login
  Widget _loginImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/barbersho.jpg'),
          fit: BoxFit.fill,
        ),
      )
    );
  }
  // widget that paint  the textfield for cell phone
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
                )
              ]
            )
          ]
        )
      )
    );
  }

  //paint the buttons for login( Facebook,apple and cellphone) and the privacity politices checkbox 
  Widget _stackButtons(BuildContext context) {
    return Column(
      children: <Widget>[
        MyCustomButtoms(
          hintText: 'Ingresar con celular',
          icon: FontAwesomeIcons.phone,
          onPressed: _submitCellphone,
          colors: [
            Color(0xFF19AEFF),
            Color(0xFF139DF7),
            Color(0xFF0A83EE),
            Color(0xFF0570E5),
            Color(0xFF0064E0)
          ]
        ),
        SizedBox(height: 20),
        MyCustomButtoms(
          hintText: 'Ingresar con Facebook',
          icon: FontAwesomeIcons.facebook,
          onPressed: _submitFacebook,
          colors: [Color(0xFF3B5998), Color(0xFF3B5998)
          ]
        ),
        CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: InkWell(
            child: new Text('Acepto terminos y condiciones',
              style: TextStyle(
                fontSize: 13,
                color: Colors.blue,
                decoration: TextDecoration.underline
              )
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PrivacyPoliticies()));
            }
          ),
          value: checkPolicies,
          onChanged: (bool value) {
            setState(() {
              checkPolicies = value;
              }
            );
          },
        )
      ]
    );
  }
  void _submitCellphone() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (checkPolicies){
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => RegisterUserData())
        );
      }else{
        showToast("Por favor acepta las políticas de privacidad", Colors.red);
      }
    }else{
      showToast("Digita un número de teléfono valido", Colors.red);
    }
  }

  void _submitFacebook() async {
    
  }



}
