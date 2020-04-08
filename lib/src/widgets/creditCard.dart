import 'package:awesome_card/extra/helper.dart';
import 'package:flutter/material.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:timugo/src/services/number_provider.dart';



class CreditCardH extends StatefulWidget {
 

  @override
  _CreditState createState() => _CreditState();
}

class _CreditState extends State<CreditCardH> {
  String cardNumber = "";
  String cardHolderName = "Titular";
  String name ='';
  String mm;
  String yy='';
  String lastname ='';
  String expiryDate = "";
  String cvv = "";
  bool showBack = false;


  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar tarjeta',style: TextStyle(color:Colors.black),),
         elevation: 0,
         leading: new IconButton(
               icon: new Icon(Icons.arrow_back, color: Colors.black,size: 35,),
               onPressed:() => Navigator.of(context).pop(),
         ),
        backgroundColor: Colors.white10,
       ),
      
      body: 
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          
        child:Stack(
        children:<Widget>[
           Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            CreditCard(
              cardNumber: cardNumber,
              cardExpiry: expiryDate,
              cardHolderName: name+lastname,
              cvv: cvv,
              bankName: "Banco",
              showBackSide: showBack,
              frontBackground: CardBackgrounds.black,
              backBackground: CardBackgrounds.white,
              showShadow: true,
              cardType: getCardType(cardNumber),
            ),
            SizedBox(
              height: 40,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                     keyboardType:TextInputType.number ,
                    decoration: InputDecoration(hintText: "Número de tarjeta"),
                    maxLength: 19,
                    onChanged: (value) {
                      setState(() {
                        cardNumber = value;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left:15,right: 15),
                  child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                  children: <Widget>[
                    Container(
                      width: 100,
                       child:TextFormField(
                         
                     keyboardType:TextInputType.number ,
                    decoration: InputDecoration(hintText: "Mes Exp."),
                    maxLength: 2,
                    onChanged: (value) {
                      setState(() {
                        mm = value;
                      });
                    },
                  )
                    ),
                  Container(
                      width: 100,
                       child:TextFormField(
                         
                     keyboardType:TextInputType.number ,
                    decoration: InputDecoration(hintText: "Año Exp."),
                    maxLength: 2,
                    onChanged: (value) {
                      setState(() {
                        yy = value;
                      });
                    },
                  )
                    ),


                  ]
                )
                ),
                // Expanded(
                 
                //   child:Row(
                //     children: <Widget>[ 
                //     TextFormField(
                //      keyboardType:TextInputType.number ,
                //     decoration: InputDecoration(hintText: "Fecha de expiración"),
                //     maxLength: 4,
                //     onChanged: (value) {
                //       setState(() {
                //         expiryDate = value;
                //       });
                //     },
                //   ),
                //   TextFormField(
                //      keyboardType:TextInputType.number ,
                //     decoration: InputDecoration(hintText: "Fecha de expiración"),
                //     maxLength: 4,
                //     onChanged: (value) {
                //       setState(() {
                //         expiryDate = value;
                //       });
                //     },
                //   )
                //   ]),
                // ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Nombre titular"),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                ),
                 Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Apellido itular"),
                    onChanged: (value) {
                      setState(() {
                        lastname = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: TextFormField(
                     keyboardType:TextInputType.number ,
                    decoration: InputDecoration(hintText: "CVV"),
                    maxLength: 3,
                    onChanged: (value) {
                      setState(() {
                        cvv = value;
                      });
                    },
                    focusNode: _focusNode,
                  ),
                ),
                
                
              ],
            )
          ],
        ),
        Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: size.height*0.04,top: size.height*0.8),
            child: RaisedButton(                                   
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.green)
              ),
              color: Colors.green.shade500,
              padding: EdgeInsets.fromLTRB(size.width*0.4, size.height*0.020, size.width*0.4, size.height*0.020),
              onPressed: (){
              _sendCard(getCardType(cardNumber).toString());

               
              } ,
              child: Text('Guardar',textAlign: TextAlign.center, style: TextStyle(color: Colors.white, ),
              ),
            ),
         )  //  c
        ]
        
      ),
       
        
      )
    );
  }
_sendCard(String franchise){
 final sendCreditCard = SendCreditCard();
 var res = sendCreditCard.sendCard( name, lastname, int.parse((expiryDate.substring(1,2))), int.parse((expiryDate.substring(3,4))),int.parse( cvv), franchise, int.parse(cardNumber));
 res.then((response) async {
   if (response['response'] == 2){
    
  }
       
          });
}


}