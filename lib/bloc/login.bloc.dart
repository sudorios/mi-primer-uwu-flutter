import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectobase/bloc/login.event.dart';
import 'package:proyectobase/bloc/login.state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int _intentosFallidos = 0;

  LoginBloc() : super(LoginState()) {
    
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, status: LoginStatus.initial));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, status: LoginStatus.initial));
    });

    on<LoginSubmitted>((event, emit) async {
      if (state.isBlocked) return;
      
      emit(state.copyWith(status: LoginStatus.submitting));    
      try {
        final QuerySnapshot result = await _firestore
            .collection('usuarios')
            .where('email', isEqualTo: state.email)
            .where('password', isEqualTo: state.password)
            .get();

        if (result.docs.isNotEmpty) {
          _intentosFallidos = 0; 
          emit(state.copyWith(status: LoginStatus.success));
        } else {
          _intentosFallidos++;          
          
          if (_intentosFallidos >= 2) {
            emit(state.copyWith(
              status: LoginStatus.blocked, 
              message: "Acceso Bloqueado. Ingrese su Año de Registro."
            ));
          } else {
            emit(state.copyWith(
              status: LoginStatus.failure,
              message: "Credenciales incorrectas (Intento $_intentosFallidos/2)"
            ));
          }
        }
      } catch (e) {
        emit(state.copyWith(
          status: LoginStatus.failure,
          message: "Error de conexión con Firebase"
        ));
      }
    });

    on<UnlockCodeChanged>((event, emit) {
      emit(state.copyWith(unlockCode: event.code));
    });

    on<UnlockSubmitted>((event, emit) async {
      
      try {
        final QuerySnapshot snapshot = await _firestore
            .collection('usuarios')
            .where('email', isEqualTo: state.email)
            .get();

        if (snapshot.docs.isEmpty) {
          emit(state.copyWith(status: LoginStatus.blocked, message: "Error: Usuario no encontrado."));
          return;
        }
        final data = snapshot.docs.first.data() as Map<String, dynamic>;      
        if (data['fecha_registro'] == null) {
           emit(state.copyWith(status: LoginStatus.blocked, message: "Este usuario no tiene fecha registrada."));
           return;
        }
        final Timestamp timestamp = data['fecha_registro']; 
        final String anioGuardado = timestamp.toDate().year.toString();
        if (state.unlockCode == anioGuardado) {
          _intentosFallidos = 0;
          emit(state.copyWith(
            status: LoginStatus.initial, 
            email: '', 
            password: '', 
            unlockCode: '',
            message: '' 
          ));
        } else {
           emit(state.copyWith(
             status: LoginStatus.blocked, 
             message: "Año incorrecto. Intente nuevamente." 
           ));
        }
      } catch (e) {
        emit(state.copyWith(status: LoginStatus.blocked, message: "Error de validación: $e"));
      }
    });
  }
}