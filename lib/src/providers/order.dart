import 'package:flutter/material.dart';

class Orderinfo with ChangeNotifier {

  int _number = 1;
  int _total = 0;
  int _count = 0;
  List _tem =['p'];
  List _orderFinal ;
  bool _boo ;

  get number {
    return _number;   
  }
  get total {
    return _total;
  }
  get count {
    return _count;
  }
   get tem {
    return _tem;
  }
   get orderFinal {
    return _orderFinal;
  }
   get boo {
    return _boo;   
  }
  
  set number(int nombre){
     this._number = nombre;
    notifyListeners();
  }
  set total( int nombre ) {
    this._total = nombre;
    notifyListeners();
  }
  set count( int nombre ) {
    this._count = nombre;
    notifyListeners();
  }
  set tem( List nombre ) {
    this._tem = nombre;
    notifyListeners();
  }
  set orderFinal( List nombre ) {
    this._orderFinal = nombre;
    notifyListeners();
  }
  set boo( bool nombre ) {
    this._boo = nombre;
    notifyListeners();
  }

}