import 'package:firebase_auth/firebase_auth.dart';

//Creamos una clase para que encapsule la logica de la autenticacion
class FirebaseAuthRepo {
  //Instanciamos 
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?>signIn(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return cred.user;
  }
  //Creamos un metodo para registrar usuarios
  Future<User?>register(String email, String password) async {
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return cred.user;
  }

  Future<void>logout() async {
    await _auth.signOut();
  }

  //Stream emite el estado del usuario autenticado(INICIADO O NO)
  Stream<User?> get user => _auth.authStateChanges();

}

