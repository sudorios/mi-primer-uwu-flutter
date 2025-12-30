import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; 

import 'package:proyectobase/bloc/user.event.dart';
import 'package:proyectobase/bloc/user.state.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance; 
  UsuarioBloc() : super(UsuarioInitialState()) {
    
    on<BuscarUsuarioEvent>((event, emit) async {
      emit(UsuarioLoadingState());
      try {
        final url = Uri.parse(
          'https://jsonplaceholder.typicode.com/posts/${event.id}',
        );
        final response = await http.get(url);
        
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          
          if (data is List) {
             emit(UsuarioErrorState("No se encontró información para el ID ${event.id}"));
             return;
          }

          final Map<String, dynamic> usuarioEncontrado = {
            'nombre': data['title'].toString().split(' ')[0],
            'apellido': 'Apellido${event.id}',
            'dni': (10000000 + int.parse(event.id)).toString(),
            'email': 'usuario${event.id}@examen.com',
            'password': 'pass${data['id']}',
          };
          emit(UsuarioLoadedState(usuarioEncontrado));
        } else {
          emit(UsuarioErrorState("No se encontró información para el ID ${event.id}"));
        }
      } catch (e) {
        emit(UsuarioErrorState("Error de conexión al buscar: $e"));
      }
    });

    on<GuardarUsuarioEvent>((event, emit) async {
      final String password = event.usuario['password'].toString();
      if (password.length < 6) {
        emit(UsuarioErrorState("La contraseña debe tener al menos 6 caracteres."));
        return;
      }

      emit(UsuarioGuardandoState(event.usuario));

      try {
        final String email = event.usuario['email'];
        final String dni = event.usuario['dni'];
        final String nombre = event.usuario['nombre'];
        final String apellido = event.usuario['apellido'];

        final QuerySnapshot result = await _firestore
            .collection('usuarios')
            .where('dni', isEqualTo: dni)
            .get();

        if (result.docs.isNotEmpty) {
          emit(UsuarioErrorState("Error: El DNI $dni ya está registrado."));
          return;
        }

        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, 
          password: password
        );

        await _firestore.collection('usuarios').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'nombre': nombre,
          'apellido': apellido,
          'dni': dni,
          'email': email,
          'password': password, 
          'fecha_registro': FieldValue.serverTimestamp(),
        });

        emit(UsuarioGuardadoState());

      } on FirebaseAuthException catch (e) {
        String mensaje = "Error de autenticación";
        if (e.code == 'email-already-in-use') mensaje = "El correo ya está registrado.";
        if (e.code == 'weak-password') mensaje = "La contraseña es muy débil (usa números y letras).";
        
        emit(UsuarioErrorState(mensaje));
      } catch (e) {
        emit(UsuarioErrorState("Error general al guardar: $e"));
      }
    });
  }
}