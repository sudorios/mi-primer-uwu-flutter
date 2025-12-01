import 'package:equatable/equatable.dart';

abstract class OperacionEditEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OperacionEditSubmitted extends OperacionEditEvent {
  final String docId; 
  final String idOperacion;
  final String descripcion;
  final int cantidad;
  final double monto;
  final String responsable;

  OperacionEditSubmitted({
    required this.docId,
    required this.idOperacion,
    required this.descripcion,
    required this.cantidad,
    required this.monto,
    required this.responsable,
  });

  @override
  List<Object?> get props =>
      [docId, idOperacion, descripcion, cantidad, monto, responsable]; 
}