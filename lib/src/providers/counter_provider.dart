import 'package:flutter/material.dart';

class Counter with ChangeNotifier {

  int _count = 0;
 
  get tot {
    return _count;
  }
 
 
  set tot( int nombre ) {
    this._count = nombre;
    notifyListeners();
  }
 

}