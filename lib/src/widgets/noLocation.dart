import 'package:flutter/material.dart';
import 'package:timugo/src/pages/services_page.dart';



class NoLocations extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: new BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF19AEFF), Color(0xFF139DF7),Color(0xFF0A83EE),Color(0xFF0570E5),Color(0xFF0064E0)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          ),
      ),
      child:Stack(
        children:<Widget>[
         Container(
    
      padding: EdgeInsets.only(top:80,left:30,right: 130),
      child: Text("Lo sentimos,   aún no tenemos cobertura          en tu zona.",
     overflow: TextOverflow.ellipsis,
     style: TextStyle(fontSize: 33.0,color: Colors.white,fontWeight: FontWeight.w800),
     maxLines: 4,
     ),
    
    ),
    Container(
          alignment: Alignment.bottomCenter,
            padding:EdgeInsets.only(bottom: size.height*0.04,left: 30,right: 30),
              
              child:RaisedButton(
                 elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                    
                  ),
                  padding: EdgeInsets.all(0.0),
                  
//
                child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.white,Colors.white],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(20.0)
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(size.width*0.1, size.height*0.005, size.width*0.1,size.height*0.005),
                        child: ListTile( trailing: Icon(Icons.add_location,color: Colors.blue,),
                         title:Text("Añade otra dirección ",textAlign: TextAlign.center,style: TextStyle(color: Colors.blue,fontSize: 18,fontWeight: FontWeight.w800))),
                      ),
                    ),


                onPressed: (){
                   Navigator.push(
                            context,  
                              MaterialPageRoute(
                                builder: (context) => Services()
                              ));
                 
                },
              
            )
          ),
        ])
    );
  }
}