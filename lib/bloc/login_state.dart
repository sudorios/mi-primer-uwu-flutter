class LoginState {
  final String email;
  final String password;
  //Nos servira para indicar si la aplicacion esta enviando las credenciales
  final bool isSubmitting;
  //Indica para saber si el login fue exitoso
  final bool isSuccess;
  final bool isFailure;

  //Constructor
  LoginState({
    required this.email,
    required this.password,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
  });

  factory LoginState.initial() {
    return LoginState(
      email: '',
      password: '',
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
