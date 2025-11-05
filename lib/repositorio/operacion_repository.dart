import 'package:cloud_firestore/cloud_firestore.dart';

class OperacionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registrarOperacion({
    required String idOperacion,
    required String descripcion,
    required int cantidad,
    required double monto,
    required String responsable,
  }) async {
    await _firestore.collection('operaciones').add({
      'idOperacion': idOperacion,
      'descripcion': descripcion,
      'cantidad': cantidad,
      'monto': monto,
      'responsable': responsable,
      'fecha': FieldValue.serverTimestamp(),
    });
  }
}
