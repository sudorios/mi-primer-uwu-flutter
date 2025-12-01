import 'package:equatable/equatable.dart';
abstract class OperacionDeleteEvent extends Equatable {
  const OperacionDeleteEvent();
  @override
  List<Object?> get props => [];
}

class OperacionDeleteRequest extends OperacionDeleteEvent {
  final String docId;
  const OperacionDeleteRequest(this.docId);
  @override
  List<Object?> get props => [docId];
}