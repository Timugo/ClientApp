import 'package:flutter/material.dart';

class RecentTransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RecentTransactionsView();
  }
}

class RecentTransactionsView extends StatefulWidget {
  @override
  _RecentTransactionsViewState createState() => _RecentTransactionsViewState();
}

class _RecentTransactionsViewState extends State<RecentTransactionsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
                padding: EdgeInsets.only(left: 12),
                child:IconButton(
               icon: Icon(Icons.arrow_back),
               
              onPressed: () {
                Navigator.pushNamed(context, 'services');
              },
              color: Colors.blue,
              
        
                )
             
            
            )
          
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Tu pedido",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\$15.000",
                      style: TextStyle(
                        fontSize: 34,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {

                         Navigator.pushNamed(context, 'feed');
                      },
                      child: Container(
                          width: double.infinity,
                          height: 60,
                          margin: EdgeInsets.only(bottom: 10),
                          alignment: FractionalOffset.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(const Radius.circular(4.0)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                             
                              Text('  Finalizar',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24)),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(26),
              width: double.infinity,
              color: Colors.black12,
              child: Text(
                "Pedidos en curso",
                style: TextStyle(fontSize: 20, color: Colors.black38),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Jeisson", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("dic 09, 10:13 PM", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                      child: ClipOval(
                          child: Image.asset(
                            "assets/images/profile.png",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                                      ),                ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
