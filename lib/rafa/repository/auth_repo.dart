import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> login(String input, String password) async {
    try {
      String email = input.trim();

      if (!email.contains('@')) {
        final querySnapshot = await _firestore
            .collection('users')
            .where('dni', isEqualTo: input.trim())
            .limit(1)
            .get();
        if (querySnapshot.docs.isEmpty) {
          throw Exception('DNI no encontrado o no registrado.');
        }
        email = querySnapshot.docs.first.data()['email'];
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User?> register({
    required String email,
    required String password,
    required String nombre,
    required String apellido,
    required String dni,
    required String direccion,
  }) async {
    try {
      final dniQuery = await _firestore
          .collection('users')
          .where('dni', isEqualTo: dni.trim())
          .get();
      if (dniQuery.docs.isNotEmpty) {
        throw Exception('El DNI ya está registrado en el sistema.');
      }

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
          'nombre': nombre,
          'apellido': apellido,
          'dni': dni,
          'direccion': direccion,
          'fecha_registro': FieldValue.serverTimestamp(),
        });
      }
      return userCredential.user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<DateTime?> getRegistrationDate(String emailOrDni) async {
    try {
      String email = emailOrDni.trim();
      // Si no tiene @, asumimos que es DNI y buscamos el usuario
      if (!email.contains('@')) {
        final querySnapshot = await _firestore
            .collection('users')
            .where('dni', isEqualTo: emailOrDni.trim())
            .limit(1)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          final data = querySnapshot.docs.first.data();
          if (data['fecha_registro'] != null) {
            return (data['fecha_registro'] as Timestamp).toDate();
          }
        }
      } else {
        // Buscar por email
        final querySnapshot = await _firestore
            .collection('users')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          final data = querySnapshot.docs.first.data();
          if (data['fecha_registro'] != null) {
            return (data['fecha_registro'] as Timestamp).toDate();
          }
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
