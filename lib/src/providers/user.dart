import 'package:flutter/material.dart';

class UserInfo with ChangeNotifier {

  int _phone = 0;
  String _name='';
  String _email ='';
  List<String> _directions=['Direccion']; 


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

}