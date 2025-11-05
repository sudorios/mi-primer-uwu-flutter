import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutteroperacionrest/model/operacion.dart';

class OperacionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _db = FirebaseFirestore.instance;
  Future<void> registrarOperacion({
    required String idOperacion,
    required String descripcion,
    required int cantidad,
    required int monto,
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

  Stream<List<Operacion>> streamOperaciones() {
    return _db
        .collection('operaciones')
        .snapshots()
        .map((qs) => qs.docs.map((doc) => Operacion.fromDoc(doc)).toList());
  }
}
