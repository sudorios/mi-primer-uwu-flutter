abstract class OperacionEvent {}

class RegistrarOperacion extends OperacionEvent {
  final String idOperacion;
  final String descripcion;
  final double monto;
  final int cantidad;
  final String responsable;

  RegistrarOperacion({
    required this.idOperacion,
    required this.descripcion,
    required this.monto,
    required this.cantidad,
    required this.responsable,
  });
}
