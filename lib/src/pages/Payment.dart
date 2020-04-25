
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timugo/src/models/card_model.dart';
import 'package:timugo/src/models/nequi_model.dart';
import 'package:timugo/src/pages/nequi_page.dart';
import 'package:timugo/src/pages/pse_page.dart';
import 'package:timugo/src/preferencesUser/preferencesUser.dart';
import 'package:timugo/src/providers/user.dart';
import 'package:timugo/src/services/number_provider.dart';
import 'package:timugo/src/widgets/creditCard.dart';

class Payment extends StatelessWidget {
  const Payment({Key key}) : super(key: key);

  void addPrincipal(String value,BuildContext context){
    final  userInfo = Provider.of<UserInfo>(context);
    final prefs = new PreferenciasUsuario();
      //this function add the principal address of user
    userInfo.payment =value;
    prefs.payment= value;

   // addFavorite.seendFavorite(value);
  }
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
        backgroundColor: Colors.white,
      ),
      // contains the  title of page ' datos del perfil'
      body: Column( 
        
        children:<Widget>[
          Container(
            padding:EdgeInsets.only(left: 15,right: 15,top: 10),
            decoration: BoxDecoration(
              color:Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)
              ), 
            ),
            child:Row(
              children: <Widget>[
                Text("Tus métodos de pago",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w600)),
              ],
            )
          ),

          _createMethods(context,'PSE',false,'assets/images/BotonPSE.png', PSEpayment()),
          _createCard(),
          _createCardNequi(),
           Container(
            margin: EdgeInsets.only(left: 15,right: 15,top:10),
            child:Text('Añadir método de pago',style:  TextStyle(color: Colors.blue,fontSize: 18,fontWeight: FontWeight.bold ),),
          ),
          Flexible(child: Column(children: <Widget>[
          _createMethods(context,'Tarjeta de crédito o débito',true,'solidCreditCard', CreditCardH()),
          _createMethods(context,'Nequi ',false,'assets/images/Nequi.png', NequiPage()),
          

          ],))
         
        ],
      )
     );
  }

  Widget _createMethods( BuildContext context,String texto,bool icon, String image,dynamic ruta){
    return  Card(
      margin: EdgeInsets.only(left: 15,right: 15,top: 10),
      shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: ListTile(
        contentPadding: EdgeInsets.only(left: icon?30:17,right: 15),
        title:Text(texto),
        leading: icon ? Icon(FontAwesomeIcons.solidCreditCard,color: Colors.black,):Image( image:AssetImage(image),width: 55,),
        trailing: Icon(FontAwesomeIcons.arrowRight,color: Colors.black,) ,
        onTap: (){
          if (icon == true) {
            texto = 'Tarjeta';
          }
          addPrincipal(texto,context);
          Navigator.push(
            context,MaterialPageRoute(
            builder: (context) => ruta
            )
          );
        },
      )
    );
  }


  Widget _createCardNequi(){
    final aditionalProvider = GetUserPayments();
    return FutureBuilder(
      future: aditionalProvider.getPaymentsNequi(),
      builder: (BuildContext context, AsyncSnapshot<List<NequiModel>> snapshot) {
        if ( snapshot.hasData ) {
          final productos = snapshot.data;
          return  ListView.builder(
             padding: EdgeInsets.only(left: 15,right: 15),
             shrinkWrap: true,
            key: UniqueKey(),
            
            itemCount: productos.length,
            itemBuilder: (context, i) => ListTileItemNequi(
            addPrincipal: ()=> addPrincipal('Nequi',context),
              producto: productos[i],)
              
          );
        }else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );
  }

   Widget _createCard(){
    final aditionalProvider = GetUserPayments();
    return FutureBuilder(
      future : aditionalProvider.getPayments(),
      builder: (BuildContext context, AsyncSnapshot<List<CardModel>> snapshot) {
        if ( snapshot.hasData ) {
          final productos = snapshot.data;
          return ListView.builder(
            padding    : EdgeInsets.only(left: 15,right: 15),
            shrinkWrap : true,
            key        : UniqueKey(),
            itemCount  : productos.length,
            itemBuilder: (context, i) => ListTileItem(
              addPrincipal: ()=> addPrincipal('Tarjeta',context),
              producto    : productos[i],
            )
          );
        }else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );
  }
}
class ListTileItem extends StatelessWidget {

  final CardModel producto;
  final Function addPrincipal;

  ListTileItem({this.producto,this.addPrincipal});

  @override
  Widget build(BuildContext context) {
    Color color = producto.favorite ? Colors.white : Colors.black;
    return  Card(
      shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Ink(
        decoration: BoxDecoration(
          gradient: producto.favorite == false?  LinearGradient(colors: [Colors.white,Colors.white]) :  LinearGradient(colors: [Color(0xFF19AEFF), Color(0xFF139DF7),Color(0xFF0A83EE),Color(0xFF0570E5),Color(0xFF0064E0)],
            begin : Alignment.centerLeft,
            end   : Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: ListTile(
          contentPadding: EdgeInsets.only(left:30,right: 15),
          title   : Text(producto.fullName,style: TextStyle(color:color),),
          subtitle: Text('**************'+producto.last4Numbers, style: TextStyle(color: color,fontSize: 15,fontWeight: FontWeight.bold)),
          leading : _chooseCard(producto.brand,color) ,
          trailing: producto.favorite ? Icon(FontAwesomeIcons.check,color: color,):  null,
          onTap   : addPrincipal
        )
      )
    );
  }

  Icon _chooseCard( card,color){
    if(card ==  'VISA'){
      return  Icon( FontAwesomeIcons.ccVisa,color: color,);
    }
    if (card ==  'MASTERD_CARD'){
      return  Icon( FontAwesomeIcons.ccMastercard,color: color);
    }
    else{
      return Icon( FontAwesomeIcons.ccAmex,color: color);
    }
  }

}
class ListTileItemNequi extends StatelessWidget {

  final NequiModel producto;
  final Function addPrincipal;

  ListTileItemNequi({this.producto,this.addPrincipal});
  @override
  Widget build(BuildContext context) {
    Color color = producto.favorite ? Colors.white : Colors.black;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 5,
      child: Ink(
        decoration: BoxDecoration(
          gradient:  producto.favorite == false?  LinearGradient(colors: [Colors.white,Colors.white]) :  LinearGradient(colors: [Color(0xFF19AEFF), Color(0xFF139DF7),Color(0xFF0A83EE),Color(0xFF0570E5),Color(0xFF0064E0)],
          begin   : Alignment.centerLeft,
          end     : Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: ListTile(
          title   : Text(producto.phone,style:  TextStyle(color:color,fontWeight: FontWeight.bold )),
          leading :Image( image:AssetImage('assets/images/Nequi.png'),width: 55,),
          subtitle: Text(producto.type, style: TextStyle(color: color, )),
          trailing:  producto.favorite ? Icon(FontAwesomeIcons.check,color: color,):  null,
          onTap: addPrincipal,
        ),
      ),
    );
  }
}
