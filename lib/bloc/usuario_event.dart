abstract class UsuarioEvent {}

class BuscarUsuarioEvent extends UsuarioEvent {
  final int id;
  BuscarUsuarioEvent(this.id);
}

class GuardarUsuarioFirebaseEvent extends UsuarioEvent {
  final Map<String, dynamic> usuario;
  GuardarUsuarioFirebaseEvent(this.usuario);
}

class LimpiarUsuarioEvent extends UsuarioEvent{}