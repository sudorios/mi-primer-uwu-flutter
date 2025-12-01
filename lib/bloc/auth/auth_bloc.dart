import 'package:appmovilpractica/bloc/auth/auth_event.dart';
import 'package:appmovilpractica/bloc/auth/auth_state.dart';
import 'package:appmovilpractica/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthRepo authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial()) {
    
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepo.login(event.emailOrDni, event.password);
        if (user != null) {
          emit(AuthSuccess(user));
        } else {
          emit(AuthFailure("No se pudo iniciar sesión."));
        }
      } catch (e) {
        emit(AuthFailure(_mapErrorMessage(e.toString())));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepo.register(
          email: event.email,
          password: event.password,
          nombre: event.nombre,
          apellido: event.apellido,
          dni: event.dni,
          direccion: event.direccion,
        );
        
        if (user != null) {
          emit(AuthSuccess(user));
        } else {
          emit(AuthFailure("No se pudo registrar el usuario."));
        }
      } catch (e) {
        emit(AuthFailure(_mapErrorMessage(e.toString())));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await authRepo.logout();
      emit(AuthInitial());
    });
  }

  String _mapErrorMessage(String error) {
    if (error.contains('user-not-found')) return 'Usuario no encontrado';
    if (error.contains('wrong-password')) return 'Contraseña incorrecta';
    if (error.contains('email-already-in-use')) return 'El correo ya está registrado';
    if (error.contains('weak-password')) return 'La contraseña es muy débil';
    return error.replaceAll("Exception: ", "").replaceAll("[firebase_auth/unknown] ", "");
  }
}