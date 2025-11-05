abstract class OperacionEvent {}
class RegistrarOperacion extends OperacionEvent {
  
  final String idOperacion;
  final String descripcion;
  final int cantidad;
  final int monto;
  final String responsable;

 RegistrarOperacion({
    required this.idOperacion,
    required this.descripcion,
    required this.cantidad,
    required this.monto,
    required this.responsable,
  });

}