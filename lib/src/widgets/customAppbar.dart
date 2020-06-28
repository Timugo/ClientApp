import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timugo/src/widgets/addDirections.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        SizedBox(
          width: 15.0,
        ),
        IconButton(
            icon: Icon(FontAwesomeIcons.userCircle,
                size: 25.0, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            }),
        Spacer(),
        FlatButton.icon(
          label: Text(
            'Dirección Actual',
          ),
          icon: Icon(Icons.arrow_drop_down),
          onPressed: () => _onButtonPressed(context),
        ),
        Spacer(),
        Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.headset,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            Container(
              child: Center(
                  child: Text(
                '1',
                style: TextStyle(color: Colors.white),
              )),
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20.0)),
            )
          ],
        ),
        Icon(FontAwesomeIcons.ellipsisV, size: 15.0, color: Colors.black),
        IconButton(
          icon:
              Icon(FontAwesomeIcons.ticketAlt, size: 15.0, color: Colors.black),
          onPressed: () {},
        ),
        SizedBox(
          width: 8.0,
        )
      ],
    );
  }
}

void _onButtonPressed(BuildContext context) {
  final size = MediaQuery.of(context).size.height;
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xFF737373),
          height: size * 0.75,
          child: Container(
            child: AddDireccions(),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
          ),
        );
      });
}
