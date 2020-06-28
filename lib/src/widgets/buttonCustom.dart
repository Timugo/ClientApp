import 'package:flutter/material.dart';


class MyCustomButtoms extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final Function onPressed;
  final List<Color> colors;

  MyCustomButtoms({this.icon, this.hintText, this.onPressed, this.colors});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RaisedButton(
      elevation: 5.0,
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      padding: EdgeInsets.all(0.0),
      child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20.0)),
          child: Container(
              padding: EdgeInsets.fromLTRB(size.width * 0.1,
                  size.height * 0.006, size.width * 0.1, size.height * 0.006),
              alignment: Alignment.center,
              child: ListTile(
                leading: Icon(icon, color: Colors.white),
                title: Text(hintText,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ))),
    );
  }
}
