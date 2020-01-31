import 'package:flutter/material.dart';

class UserInfo with ChangeNotifier {

  int _phone = 0;
  String _name='';
  String _email ='';
  List<String> _directions=['Direccion']; 
  String _urlImg;
  String _price;
  int _pts;

  get phone {
    return _phone;
  }
  get name {
    return _name;
  }
  get email {
    return _email;
  }
   get directions {
    return _directions;
  }
  
  get urlImg {
    return _urlImg;
  }
  get price {
    return _price;
  }
  get pts{
    return _pts;
  }
  set pts(int nombre){
     this._pts = nombre;
    notifyListeners();
  }
  set phone( int nombre ) {
    this._phone = nombre;
    notifyListeners();
  }
  set name( String nombre ) {
    this._name = nombre;
    notifyListeners();
  }
  set email( String nombre ) {
    this._email = nombre;
    notifyListeners();
  }
  
  set directions( List nombre ) {
    if (nombre != null) {
      this._directions= nombre;
    notifyListeners();
      
    }
    
  }

  set urlImg( String nombre ) {
    this._urlImg = nombre;
    notifyListeners();
  }
  set price( String nombre ) {
    this._price = nombre;
    notifyListeners();
  }


}