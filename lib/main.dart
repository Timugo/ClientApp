
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timugo/src/pages/codeVerification_page.dart';
import 'package:timugo/src/pages/login_pages.dart';
import 'package:timugo/src/pages/registerData_page.dart';
import 'package:timugo/src/pages/services_pages.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/providers/user.dart';


 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();

 runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
  

    return MultiProvider(
      providers: [
        ChangeNotifierProvider( builder: (context) => UserInfo() ),
      
      ],
      child: MaterialApp(
        
       
        debugShowCheckedModeBanner: false,
        initialRoute:_rute(),
        
        routes: {
          'login':(context)=> LoginPage(),
          'code':(context)=> Code(),
          'registerData':(context)=> RegisterData(),
          'services':(context)=> Services()


        
        },
       
      )
    );
      
      
      
    
  }

   _rute<String> () {
    final prefs = new PreferenciasUsuario();
    print(prefs.token);
    if (prefs.token!= '') {
      var ruta='services';
      return ruta;
      
    }else{

      return 'login';
    }



  }
}
