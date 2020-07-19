import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void showToast(String message, Color color,) {
  // show the toast message in bell appbar
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 14.0
  );
}
