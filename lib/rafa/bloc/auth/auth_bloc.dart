import 'package:appmovilfirebasecuartoexamen/bloc/auth/auth_event.dart';
import 'package:appmovilfirebasecuartoexamen/bloc/auth/auth_state.dart';
import 'package:appmovilfirebasecuartoexamen/repository/api_repository.dart';
import 'package:appmovilfirebasecuartoexamen/repository/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthRepo authRepo;
  final ApiRepository apiRepository = ApiRepository();

  int _failedAttempts = 0;
  bool _isLocked = false;
  String _currentRecoveryKey = "111";

  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      if (_isLocked) {
        emit(AuthLocked(recoveryKey: _currentRecoveryKey));
        return;
      }
      emit(AuthLoading());
      try {
        final user = await authRepo.login(event.emailOrDni, event.password);
        if (user != null) {
          _failedAttempts = 0;
          emit(AuthSuccess(user));
        } else {
          await _handleLoginFailure(
            emit,
            "Credenciales inválidas",
            event.emailOrDni,
          );
        }
      } catch (e) {
        await _handleLoginFailure(
          emit,
          _mapErrorMessage(e.toString()),
          event.emailOrDni,
        );
      }
    });

    // --- NUEVO: Manejador de Desbloqueo ---
    on<UnlockRequested>((event, emit) {
      if (event.code == _currentRecoveryKey) {
        _isLocked = false;
        _failedAttempts = 0;
        _currentRecoveryKey = "111";
        emit(AuthInitial()); // Volver al estado normal
      } else {
        emit(AuthFailure("Código de recuperación incorrecto"));
        // Importante: Volver a emitir Locked para que la UI no se desbloquee visualmente
        Future.delayed(Duration(milliseconds: 100), () => emit(AuthLocked()));
      }
    });

    on<FetchUserRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final userData = await apiRepository.fetchUserById(event.id);
        if (userData != null) {
          emit(UserFetchSuccess(userData));
        } else {
          emit(UserFetchFailure("Usuario no encontrado en API"));
        }
      } catch (e) {
        emit(UserFetchFailure("Error al buscar usuario: $e"));
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
    if (error.contains('email-already-in-use'))
      return 'El correo ya está registrado';
    if (error.contains('weak-password')) return 'La contraseña es muy débil';
    return error
        .replaceAll("Exception: ", "")
        .replaceAll("[firebase_auth/unknown] ", "");
  }

  // Helper para manejar fallos y conteo
  Future<void> _handleLoginFailure(
    Emitter<AuthState> emit,
    String error,
    String emailOrDni,
  ) async {
    _failedAttempts++;
    if (_failedAttempts >= 2) {
      _isLocked = true;

      // Buscar fecha de registro
      final date = await authRepo.getRegistrationDate(emailOrDni);
      if (date != null) {
        _currentRecoveryKey = date.year.toString();
      } else {
        _currentRecoveryKey = "111";
      }
      emit(AuthLocked(recoveryKey: _currentRecoveryKey));
    } else {
      emit(AuthFailure(error));
    }
  }
}
