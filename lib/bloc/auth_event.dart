abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested(this.email, this.password);
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;

  RegisterRequested(this.email, this.password);
}

//Evento que lanza cuando un usuario cierra sesion
class LogoutRequested extends AuthEvent{} 