import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:timugo_client_app/providers/register_provider.dart';

import 'model_feed.dart';



class FeedBack extends StatefulWidget {
  @override
  _TestState createState() => new _TestState();
}

class _TestState extends State<FeedBack> {
  TextEditingController feedController = new TextEditingController();
  final  feedOrder =FeedProvider();
  FeedModel feed = FeedModel();
  double rating = 0;
  int starCount = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body:Column(
        
      
        children: <Widget>[
         
          
          
          SizedBox(height: 70.0),
          Text('Como te fue con Timugo?',style: TextStyle(fontSize: 20.0),),
          
         new Container(height: 1,  color: Colors.black,
                    margin: const EdgeInsets.only(left: 30.0, right: 30.0,top: 20),),
          new Container(
            
            child: new StarRating(
              size: 60.0,
              rating: rating,
              color: Colors.orange,
              borderColor: Colors.grey,
              starCount: starCount,
              onRatingChanged: (rating) => setState(
                    () {
                      this.rating = rating;
                      feed.stars = rating.toInt();
                    },
                  ),
            ),
          ),
           

          Padding(
                    padding: EdgeInsets.only(left: 50.0, right: 50.0,top: 20,bottom: 20),

                    child: new Theme(
                  data: new ThemeData(
                    primaryColor: Colors.blue,
                  
                  ),
                    child: TextField(
                      controller: feedController,
                      decoration: InputDecoration(
                        hintText: "Dejanos tu comentario",
                        
                      
                    border: new OutlineInputBorder(
                       borderSide: const BorderSide(color: Colors.blue),
                       borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      
                      ),
                      
              ),
        
                      ),

                      
                      maxLines: 8,
                    ),
                  ),
          ),
           new Container(height: 1,  color: Colors.black,
                    margin: const EdgeInsets.only(left: 30.0, right: 30.0,bottom: 10),),
          Container(
            child: RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 150.0, vertical: 15.0),
          child: Text('enviar'),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0)
        ),
        elevation: 0.0,
        color: Colors.red,
        textColor: Colors.white,
        onPressed: (){
          print('la');
          feed.comment=feedController.text;
          feed.idOrder=1;
            var res= feedOrder. finishOrder(feed);
                  res.then((response) async {
          
                    if (response['response'] == 2){
              
                    Navigator.pushNamed(context, 'services');
                    //    builder: (context) => Login()));


                    }
                  });
        },
        
            )
          



  
      
          )
          
        ],
      ),
      
      
    );
  }
}