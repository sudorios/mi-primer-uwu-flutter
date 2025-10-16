abstract class AuthState{}
//Representa el estado inicial de la autenticación
class AuthInitial extends AuthState{}
class AuthLoading extends AuthState{}
class AuthSuccess extends AuthState{}
class AuthFailure extends AuthState{
  final String error;
  //Creamos el constructor
  AuthFailure(this.error);
}