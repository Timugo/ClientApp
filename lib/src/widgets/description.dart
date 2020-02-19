
import 'package:flutter/material.dart';
import 'package:timugo/src/models/barbers_model.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart'; 


class Description extends StatelessWidget {
    Description(this.prod);
    final BarbersModel prod;
     final url ='https://timugo.tk/';
     
     
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
    
        child:Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset (20.0,-50),
              child: CircleAvatar(
                radius:80.0,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundImage:NetworkImage(url+prod.urlImg),
                  radius:75
                ),
                  
              ),
              
            ),
            
            Container(
              padding: EdgeInsets.only(top: 110,left:25),
              child:
            
            Text(
              prod.name,
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold ),
             ),
            
            ),

            Container(
              padding: EdgeInsets.only(top: 145,left: 25),
              child:SmoothStarRating(
                allowHalfRating: false,
                starCount: 5,
                rating:prod.stairs,
                size: 25.0,
                filledIconData: Icons.star,
                halfFilledIconData: Icons.blur_on,
                color: Colors.blue,
                borderColor: Colors.blue,
                spacing:0.0
               ),
            
            ),
            Container(
              padding: EdgeInsets.only(top: 180,left: 13),
              child:ListTile(
                title:Text('Bio', style: TextStyle(
                      fontSize: 30,fontWeight: FontWeight.bold
                    ),
                ),
              subtitle: Text(prod.bio),
              )
            )
      
          ]
        )
      )
    );
  }

        
        


        
      
    
  

    }