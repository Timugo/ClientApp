import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotificationsView();
  }
}

class NotificationsView extends StatefulWidget {
  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

const kExpandedHeight = 300.0;

class _NotificationsViewState extends State<NotificationsView> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: kExpandedHeight,
                floating: false,
                automaticallyImplyLeading: false,
                pinned: true,
                backgroundColor: Colors.black,
                leading: GestureDetector(
                  child: IconButton(
                    onPressed: ()=> Navigator.pop(context),
                    icon: Icon(Icons.close, size: 28, color: Colors.white),
                  ),
                ),
                actions: <Widget>[
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: <Widget>[
                      Container(
                        height: 300,
                        decoration: BoxDecoration(color: Colors.black),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              height: 80,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                              
                                
                                ProfileButton(
                                  icon: Icons.star,
                                  title: "Jeisson",
                                  rating: "4.88",
                                ),
                              
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ];
          },
          body: Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Descripcion",
                      style: TextStyle(fontSize: 28, color: Colors.black),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title:
                        Text("Soy, Jeisson", style: TextStyle(fontSize: 20)),
                    subtitle: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text("Me gusta trasquilar wey no mames",
                            style: TextStyle(fontSize: 16))),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.blue, shape: BoxShape.circle),
                      child: Icon(
                        Icons.person_pin,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class FunctionalButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function() onPressed;

  const FunctionalButton({Key key, this.title, this.icon, this.onPressed})
      : super(key: key);

  @override
  _FunctionalButtonState createState() => _FunctionalButtonState();
}

class _FunctionalButtonState extends State<FunctionalButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RawMaterialButton(
          onPressed: widget.onPressed,
          splashColor: Colors.black,
          fillColor: Colors.blue,
          elevation: 15.0,
          shape: CircleBorder(),
          child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                widget.icon,
                size: 50.0,
                color: Colors.white,
              )),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

class ProfileButton extends StatefulWidget {
  final String title, rating;
  final IconData icon;
  final Function() onPressed;

  const ProfileButton(
      {Key key, this.title, this.rating, this.icon, this.onPressed})
      : super(key: key);

  @override
  _ProfileButtonState createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipOval(
                child: Image.asset(
                  "assets/images/profile.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
          Positioned(
            left: 14,
            top: 75,
            child: Container(
              width: 70,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(widget.rating,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    widget.icon,
                    color: Colors.black,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
