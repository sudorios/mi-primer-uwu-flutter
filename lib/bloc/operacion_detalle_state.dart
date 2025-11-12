import 'package:equatable/equatable.dart';
import 'package:flutteroperacionrest/model/operacion.dart';

abstract class OperacionDetalleState extends Equatable {
  const OperacionDetalleState();

  @override
  List<Object?> get props => [];
}

class OperacionDetalleLoading extends OperacionDetalleState {}
class OperacionDetalleLoaded extends OperacionDetalleState {
  final Operacion operacion;
  const OperacionDetalleLoaded(this.operacion);
  @override
  List<Object?> get props => [operacion];
}

class OperacionDetalleError extends OperacionDetalleState {
  final String error;
  const OperacionDetalleError(this.error);
  @override
  List<Object?> get props => [error];
} 