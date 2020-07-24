// Flutter dependencies
import 'package:flutter/material.dart';

class BarberAsigned with ChangeNotifier {
  // Properties
  String _phone = '000-000-000';
  String _name='Sin Asignar';
  String _urlImg = '';
  double _stairs = 0.0;
  
  //Getters
  get phone {
    return _phone;
  }
  get name {
    return _name;
  }
  get urlImg {
    return _urlImg;
  }
  get stairs {
    return _stairs;
  }
  
  // Setters
  set phone( String value ) {
    this._phone = value;
    notifyListeners();
  }
  set name( String value ) {
    this._name = value;
    notifyListeners();
  }
  set urlImg( String value ) {
    this._urlImg = value;
    notifyListeners();
  }
  set stairs( double value ) {
    this._stairs = value;
    notifyListeners();
  }
}