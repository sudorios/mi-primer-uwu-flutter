abstract class OperacionState {}

class OperacionInitial extends OperacionState {}

class OperacionLoading extends OperacionState {}

class OperacionSuccess extends OperacionState {}

class OperacionFailure extends OperacionState {
  final String error;
  OperacionFailure(this.error);
}
