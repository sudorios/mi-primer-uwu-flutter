import 'package:equatable/equatable.dart';

abstract class UsuarioEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class BuscarUsuarioEvent extends UsuarioEvent {
  final String id;
  BuscarUsuarioEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GuardarUsuarioEvent extends UsuarioEvent {
  final Map<String, dynamic> usuario;
  GuardarUsuarioEvent(this.usuario);

  @override
  List<Object> get props => [usuario]; 
}