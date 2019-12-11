import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'login_validators.dart';

//Para mandar información a cualquier vista
class LoginBloc with Validators {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  // final _phoneController = StreamController<String>.broadcast();
  final _phoneController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();

  // Recuperar/escuchar los datos del Stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);
  Stream<String> get phoneStream => _phoneController.stream.transform(validarPhone);
  Stream<String> get nameStream => _nameController.stream;

  Stream<bool> get formValidStream =>
    Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Insertar valores al Stream
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;
  Function(String) get changeName => _nameController.sink.add;

  //Obtener el ultimo valor tomado del stream
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get phone => _phoneController.value;
  String get name => _nameController.value;


  //Cerrar métodos para cuando no se necesiten

  dispose() {
    _emailController?.close();  
    _passwordController?.close();
    _phoneController?.close();
    _nameController?.close();
  }

}