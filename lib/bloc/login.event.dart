abstract class LoginEvent {}

class EmailChanged extends LoginEvent {
  final String email;
  EmailChanged({required this.email});
}

class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {}

class UnlockCodeChanged extends LoginEvent {
  final String code;
  UnlockCodeChanged({required this.code});
}

class UnlockSubmitted extends LoginEvent {}