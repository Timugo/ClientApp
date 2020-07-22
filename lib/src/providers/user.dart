import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UserInfo with ChangeNotifier {
  
  // Properties
  int _phone = 0;
  int _pts;
  String _name='';
  String _email ='';
  String _registerMethod;
  String _directions; 
  String _urlImg;
  String _price;
  String _city='Cali';
  String _publicityMethod;
  String _payment='Efectivo';
  Position _loca;
  
  //Getters & SETTERS
  get phone {
    return _phone;
  }
  set phone( int nombre ) {
    this._phone = nombre;
    notifyListeners();
  }
  get registerMethod {
    return _registerMethod;
  }
  set registerMethod(String registerMethod){
    this._registerMethod = registerMethod;
    notifyListeners();
  }
  get name {
    return _name;
  }
  set name( String nombre ) {
    this._name = nombre;
    notifyListeners();
  }
  get email {
    return _email;
  }
  set email( String nombre ) {
    this._email = nombre;
    notifyListeners();
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
  get publicityMethod {
    return _publicityMethod;
  }
  get loca {
    return _loca;
  }
  get payment {
    return _payment;
  }
  set payment(String nombre){
    this._payment = nombre;
    notifyListeners();
  }
  set loca(Position nombre){
    this._loca = nombre;
    notifyListeners();
  }
  set publicityMethod(String method){
    this._publicityMethod = method;
    notifyListeners();
  }
  set pts(int nombre){
    this._pts = nombre;
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