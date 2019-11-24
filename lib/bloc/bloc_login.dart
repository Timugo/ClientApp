import 'dart:async';

//Para mandar información a cualquier vista
class LoginBloc {

  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  // Recuperar los datos del Stream
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passwordStream => _passwordController.stream;

  // Insertar valores al Stream
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;


  //Cerrar métodos

  dispose() {
    _emailController?.close();  
    _passwordController?.close();
  }

}