import 'package:equatable/equatable.dart';
import '../model/operacion.dart';

abstract class OperacionListState extends Equatable {
  const OperacionListState();

  @override
  List<Object?> get props => [];
}

class OperacionListLoading extends OperacionListState {
  const OperacionListLoading();
}

class OperacionListLoaded extends OperacionListState {
  final List<Operacion> operaciones;
  const OperacionListLoaded(this.operaciones);

  @override
  List<Object?> get props => [operaciones];
}

class OperacionListError extends OperacionListState {
  final String error;
  const OperacionListError(this.error);

  @override
  List<Object?> get props => [error];
}