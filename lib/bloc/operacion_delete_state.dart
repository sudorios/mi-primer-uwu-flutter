import 'package:equatable/equatable.dart';

abstract class OperacionDeleteState extends Equatable {
  const OperacionDeleteState();
  @override
  List<Object?> get props => [];
}

class OperacionDeleteInitial extends OperacionDeleteState {}
class OperacionDeleteLoading extends OperacionDeleteState {}
class OperacionDeleteSuccess extends OperacionDeleteState {}
class OperacionDeleteFailure extends OperacionDeleteState {
  final String error;
  const OperacionDeleteFailure(this.error); 
  @override
  List<Object?> get props => [error];
}