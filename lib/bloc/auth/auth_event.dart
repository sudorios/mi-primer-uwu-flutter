
abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String emailOrDni;
  final String password;
  LoginRequested(this.emailOrDni, this.password);
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String nombre;
  final String apellido;
  final String dni;
  final String direccion;

  RegisterRequested({
    required this.email,
    required this.password,
    required this.nombre,
    required this.apellido,
    required this.dni,
    required this.direccion,
  });
}

class LogoutRequested extends AuthEvent {}