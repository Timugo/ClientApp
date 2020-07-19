// Flutter dependencies
import 'package:flutter/material.dart';
// Plugins
import 'package:fluttertoast/fluttertoast.dart';

/*
  This function display a toast in the current
  screen
*/
void showToast(String message, Color color,) {
  // show the toast message in bell appbar
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 14.0
  );
}
