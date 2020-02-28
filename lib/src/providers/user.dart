import 'package:flutter/material.dart';

class UserInfo with ChangeNotifier {

  int _phone = 0;
  String _name='';
  String _email ='';
  String _directions=''; 
  String _urlImg;
  String _price;
  int _pts;
  String _city='Cali';
  String _publi;

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
  get city {
    return _city;
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
  get publi {
    return _publi;
  }
   set publi(String nombre){
     this._publi = nombre;
    notifyListeners();
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
  
  set directions( String nombre ) {
    
      this._directions= nombre;
    notifyListeners();

  }

  set urlImg( String nombre ) {
    this._urlImg = nombre;
    notifyListeners();
  }
  set price( String nombre ) {
    this._price = nombre;
    notifyListeners();
  }
  set city( String nombre ) {
    this._city = nombre;
    notifyListeners();
  }


}