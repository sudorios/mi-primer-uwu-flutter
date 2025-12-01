import 'package:equatable/equatable.dart';

abstract class OperacionEditState extends Equatable {
  const OperacionEditState();
  @override
  List<Object?> get props => [];
}

class OperacionEditInitial extends OperacionEditState {
  const OperacionEditInitial();
}

class OperacionEditLoading extends OperacionEditState {
  const OperacionEditLoading();
}

class OperacionEditSuccess extends OperacionEditState {
  const OperacionEditSuccess();
}

class OperacionEditFailure extends OperacionEditState {
  final String error;
  const OperacionEditFailure(this.error);
  
  @override
  List<Object?> get props => [error];
}