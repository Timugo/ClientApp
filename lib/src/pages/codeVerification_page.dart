// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:provider/provider.dart';
// import 'package:timugo/src/loginPage/login_page.dart';
// import 'package:timugo/src/models/user_model.dart';

// import 'package:timugo/src/pages/registerData_page.dart';
// import 'package:timugo/src/pages/services_page.dart';

// import 'package:timugo/src/preferencesUser/preferencesUser.dart';

// import 'package:timugo/src/providers/user.dart';
// import 'package:timugo/src/services/number_provider.dart';

// class Code extends StatelessWidget {
//   final Model model;

//   Code({this.model});
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           PinCodeVerificationScreen(model.phone.toString()),
//         ],
//       ),

//       // a random number, please don't call xD
//     );
//   }
// }

// class PinCodeVerificationScreen extends StatefulWidget {
//   final String phoneNumber;
//   PinCodeVerificationScreen(this.phoneNumber);

//   @override
//   _PinCodeVerificationScreenState createState() =>
//       _PinCodeVerificationScreenState();
// }

// class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
//   var onTapRecognizer;

//   /// this [StreamController] will take input of which function should be called

//   bool hasError = false;
//   String currentText = '';
//   final sendToken = TokenProvider();

//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     onTapRecognizer = TapGestureRecognizer()
//       ..onTap = () {
//         Navigator.pop(context);
//       };

//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final  codeProvider = CodeProvider();
//     final verificateProvider = VerificateProvider();
//     final userInfo = Provider.of<UserInfo>(context);
//     final size = MediaQuery.of(context).size;
//     final prefs = new PreferenciasUsuario();

//     var stam = size.width * 0.1;

//     return Scaffold(
//       key: scaffoldKey,
//       body: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).requestFocus(new FocusNode());
//         },
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: ListView(
//             children: <Widget>[
//               SizedBox(height: 20),
//               Container(
//                 alignment: Alignment.bottomLeft,
//                 child: FlatButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => LoginPage()));
//                   },
//                   child: Column(
//                     children: <Widget>[
//                       Icon(Icons.arrow_back),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Text(
//                   'Código de verificación ',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: size.width * 0.05, vertical: 8),
//                 child: RichText(
//                   text: TextSpan(
//                       text: "Introduce tu código enviado  al: +57 ",
//                       children: [
//                         TextSpan(
//                             text: widget.phoneNumber,
//                             style: TextStyle(
//                                 color: Color(0xFF91D3B3),
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 17)),
//                       ],
//                       style: TextStyle(color: Colors.black54, fontSize: 15)),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                   padding:
//                       EdgeInsets.symmetric(vertical: 8.0, horizontal: stam),
//                   child: PinCodeTextField(
//                     length: 6,
//                     obsecureText: false,
//                     animationType: AnimationType.fade,
//                     shape: PinCodeFieldShape.box,
//                     animationDuration: Duration(milliseconds: 300),
//                     borderRadius: BorderRadius.circular(10),
//                     fieldHeight: 40,
//                     fieldWidth: 40,
//                     onChanged: (value) {
//                       setState(() {
//                         currentText = (value);
//                       });
//                     },
//                   )),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
//                 // error showing widget
//                 child: Text(
//                   hasError ? "*Codigó invalido" : "",
//                   style: TextStyle(color: Colors.red.shade300, fontSize: 15),
//                 ),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               RichText(
//                 textAlign: TextAlign.center,
//                 text: TextSpan(
//                     text: "¿No recibió el código? ",
//                     style: TextStyle(color: Colors.black54, fontSize: 15),
//                     children: [
//                       TextSpan(
//                         text: " Reenviar",
//                         recognizer: onTapRecognizer,
//                         style: TextStyle(
//                             color: Color(0xFF91D3B3),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16),
//                       )
//                     ]),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
//                 child: ButtonTheme(
//                   height: 50,
//                   child: FlatButton(
//                     onPressed: () {
//                       // conditions for validating
//                       if (currentText.length != 6) {
//                         setState(() {
//                           hasError = true;
//                         });
//                       } else {
//                         setState(() {
//                           hasError = false;
//                           var res = verificateProvider.verificateCode(
//                               userInfo.phone.toString(), currentText);
//                           res.then((response) async {
//                             print(response['response']);
//                             if (response['response'] == 2) {
//                               if (response['content']['code'] == 1) {
//                                 prefs.token = userInfo.phone.toString();
//                                 sendToken.sendToken(userInfo.phone.toString(),
//                                     prefs.tokenPhone.toString());

//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => RegisterData()));
//                               } else {
//                                 prefs.token = userInfo.phone.toString();
//                                 sendToken.sendToken(userInfo.phone.toString(),
//                                     prefs.tokenPhone.toString());

//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Services()));
//                               }
//                             } else {
//                               setState(() {
//                                 hasError = true;
//                               });
//                             }
//                           });
//                         });
//                       }
//                     },
//                     child: Ink(
//                       decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               Color(0xFF19AEFF),
//                               Color(0xFF139DF7),
//                               Color(0xFF0A83EE),
//                               Color(0xFF0570E5),
//                               Color(0xFF0064E0)
//                             ],
//                             begin: Alignment.centerLeft,
//                             end: Alignment.centerRight,
//                           ),
//                           borderRadius: BorderRadius.circular(20.0)),
//                       child: Container(
//                           padding: EdgeInsets.fromLTRB(
//                               size.width * 0.2, 20.0, size.width * 0.2, 20.0),
//                           child: Text(
//                             'Verificar ',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(color: Colors.white, fontSize: 18),
//                           )),
//                     ),
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//   //  void _subimit(phoneNumber){
//   //    final  registeProvider = NumberProvider();

//   //       var res= registeProvider.sendNumber(phoneNumber);
//   //       res.then((response) async {
//   //         if (response['response'] == 2){

//   //         }else{
//   //           print( response['content']);
//   //         }
//   //       });

//   //  }
// }
