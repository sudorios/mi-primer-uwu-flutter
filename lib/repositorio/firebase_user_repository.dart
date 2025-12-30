import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> guardarUsuario(Map<String, dynamic> usuario) async {
    if(usuario['id'] == null){
      throw Exception('El usuario debe tener un campo "id" para ser guardado en Firestore.');
    }
    final String userId = usuario['id'].toString();
    await _firestore.collection('usuarios').doc(userId).set({
    ...usuario,
    'registro': DateTime.now().toIso8601String(),
    }, SetOptions(merge: true));
  }
}