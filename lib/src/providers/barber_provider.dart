import 'package:flutter/material.dart';

class BarberAsigned with ChangeNotifier {

  String _phone = '000-000-000';
  String _name='Sin Asignar';
  String _urlImg = '';
  double _stairs = 0.0;
  
 

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
  

  set phone( String nombre ) {
    this._phone = nombre;
    notifyListeners();
  }
  set name( String nombre ) {
    this._name = nombre;
    notifyListeners();
  }

  set urlImg( String nombre ) {
    this._urlImg = nombre;
    notifyListeners();
  }
  set stairs( double nombre ) {
    this._stairs = nombre;
    notifyListeners();
  }


}