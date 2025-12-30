
abstract class UsuarioState {}

class UsuarioInitialState extends UsuarioState {}

class UsuarioLoadingState extends UsuarioState {}

class UsuarioLoadedState extends UsuarioState {
  final Map<String, dynamic> usuario;
  UsuarioLoadedState(this.usuario);
}

class UsuarioErrorState extends UsuarioState {
  final String message;
  UsuarioErrorState(this.message);
}

class UsuarioGuardandoState extends UsuarioState {
  final Map<String, dynamic> usuario;
  UsuarioGuardandoState(this.usuario);
}

class UsuarioGuardadoState extends UsuarioState {}
