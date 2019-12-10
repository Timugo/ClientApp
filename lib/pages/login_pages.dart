import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:timugo_client_app/models/dataClient_models.dart';
import 'package:timugo_client_app/pages/services_pages.dart';
import 'package:timugo_client_app/providers/login_providers.dart';
import 'package:timugo_client_app/providers/providers.dart';
import 'package:timugo_client_app/providers/sqlite_providers.dart';

class  Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: <Widget>[
           Container(
      
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/timugo.png'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            //  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop)
            )
          ),
        ),
        Container( 
          child: StreamBuilder(
             stream: Connectivity().onConnectivityChanged,
            builder: (BuildContext ctxt,
                AsyncSnapshot<ConnectivityResult> snapShot) {
              if (!snapShot.hasData) return CircularProgressIndicator();
              var result = snapShot.data;
              switch (result) {
                case ConnectivityResult.none:
                  return Center(child: Text("No hay conexión a Internet!"));
                case ConnectivityResult.mobile:
                 return Center(
                    child: _loginForm(context)
                  );
                case ConnectivityResult.wifi:
                  return Center(
                    child: _loginForm(context)
                  );
                default:
                  return Center(child: Text("No hay conexión a Internet!"));
              }
            }


          )
        )
          
        ]
                
      ),
      
    );
  }
}

Widget _loginForm(BuildContext context) {

  final bloc = Provider.of(context);
  final size = MediaQuery.of(context).size;

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
              _crearEmail( bloc ),
              SizedBox(height: 30.0),
              _crearPassword( bloc ),
              SizedBox(height: 90.0),
              _crearBoton( bloc )
            ],
          ),
        ),
        GestureDetector(
          child: Text('¿No tiene cuenta?, Registrese Aquí', style: TextStyle(decoration: TextDecoration.underline),),
          onTap: (){
            Navigator.pushNamed(context, 'register');
          },
        ),
        SizedBox(height: 80.0,)
      ],
    ),
  );
}

Widget _crearEmail(LoginBloc bloc) {
   return StreamBuilder(
    stream: bloc.emailStream,
    builder: (BuildContext context, AsyncSnapshot snapshot){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),

        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            icon: Icon( Icons.alternate_email, color: Colors.black),
            hintText: 'ejemplo@correo.com',
            labelText: 'Correo electrónico',
            // counterText: snapshot.data,
            errorText: snapshot.error,
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
          onChanged: ( value ) => bloc.changeEmail(value),
        ),
      );
    },
  );
}

Widget _crearPassword(LoginBloc bloc) {

  return StreamBuilder(
    stream: bloc.passwordStream,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon( Icons.lock, color: Colors.black),
            labelText: 'Contraseña',
            // counterText: snapshot.data,
            errorText: snapshot.error,
            enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 0.0),
                borderRadius: const BorderRadius.all(
                const Radius.circular(30.0),
                ),
            ),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(30.0),
              ),
            )
        ),
        onChanged: ( value ) => bloc.changePassword(value),
        ),
      );
    },
  );
}

Widget _crearBoton(LoginBloc bloc){

  return StreamBuilder(
    stream: bloc.formValidStream,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 90.0, vertical: 20.0),
          child: Text('Ingresar'),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0)
        ),
        elevation: 0.0,
        color: Colors.red,
        textColor: Colors.white,
        onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
      );
    },
  ); 
}

_login(LoginBloc bloc, BuildContext context) {

  print("===========");
  print('Email: ${ bloc.email }');
  print('Password: ${ bloc.password }');
  print("===========");

  final loginProvider = new LoginProvider();
  final response = loginProvider.login(bloc.email, bloc.password);
  response.then((res) async {
    if(res['response'] == 2){
      await ClientDB.db.addClient(new DataClient(
        id: res['content']['user']['id'],
        name: res['content']['user']['name'],
        lastName: res['content']['user']['lastName'],
        address: res['content']['user']['address'],
        email: res['content']['user']['email'],
        birthdate: res['content']['user']['birthdate'],
        phone: res['content']['user']['phone'],
        token:res['content']['user']['token']
      ));
      Navigator.push(context,MaterialPageRoute(builder: (context) => Service()));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Ups Parcero"),
            content: new Text("Usuario o contraseña incorrectos"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Cerrar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      );
    }
  });
}
