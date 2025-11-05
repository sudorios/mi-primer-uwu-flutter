import 'package:cloud_firestore/cloud_firestore.dart';

class Operacion {
  final String docId;
  final String idOperacion;
  final String descripcion;
  final int cantidad;
  final double monto;
  final String responsable;
  final DateTime? fecha;

  Operacion({
    required this.docId,
    required this.idOperacion,
    required this.descripcion,
    required this.cantidad,
    required this.monto,
    required this.responsable,
    this.fecha,
  });

  factory Operacion.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};

    return Operacion(
      docId: doc.id,
      idOperacion: data['idOperacion'] ?? '',
      descripcion: data['descripcion'] ?? '',
      cantidad: (data['cantidad'] is int)
          ? data['cantidad']
          : int.tryParse(data['cantidad']?.toString() ?? '0') ?? 0,
      monto: (data['monto'] is num)
          ? (data['monto'] as num).toDouble()
          : double.tryParse(data['monto']?.toString() ?? '0') ?? 0.0,
      responsable: data['responsable'] ?? '',
      fecha: (data['fecha'] is Timestamp)
          ? (data['fecha'] as Timestamp?)?.toDate()
          : null,
    );
  }
}
