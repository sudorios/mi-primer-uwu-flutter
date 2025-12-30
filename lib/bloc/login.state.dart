enum LoginStatus { initial, submitting, success, failure, blocked }

class LoginState {
  final String email;
  final String password;
  final String unlockCode;
  final LoginStatus status;
  final String message;

  LoginState({
    this.email = '',
    this.password = '',
    this.unlockCode = '',
    this.status = LoginStatus.initial,
    this.message = '',
  });


  bool get isSubmitting => status == LoginStatus.submitting;
  bool get isSuccess => status == LoginStatus.success;
  bool get isFailure => status == LoginStatus.failure;
  bool get isBlocked => status == LoginStatus.blocked;

  LoginState copyWith({
    String? email,
    String? password,
    String? unlockCode,
    LoginStatus? status,
    String? message,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      unlockCode: unlockCode ?? this.unlockCode,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}