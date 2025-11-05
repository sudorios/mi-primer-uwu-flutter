import 'package:equatable/equatable.dart';

abstract class OperacionListState extends Equatable {
  const OperacionListState();
  @override
  List<Object> get props => [];
}

class OperacionListLoading extends OperacionListState {
  const OperacionListLoading();
}

class OperacionListLoaded extends OperacionListState {
  final List operaciones;
  const OperacionListLoaded({required this.operaciones});

  @override
  List<Object> get props => [operaciones];
}

class OperacionListError extends OperacionListState {
  final String message;
  const OperacionListError({required this.message});

  @override
  List<Object> get props => [message];
}
