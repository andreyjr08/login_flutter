import 'dart:async';
import 'package:form_validate/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{
  final _emailController =    BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

//recuperar valores de Stream
  Stream<String> get emailStream => _emailController.stream.transform( validarEmail );
  Stream<String> get passwordStream => _passwordController.stream.transform( validarPassword );
  
  Stream<bool> get fomrValidStream => 
  Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

//Añadir valores a Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

//Obtener ultimo valor de Stream
String get email => _emailController.value;
String get password => _passwordController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
