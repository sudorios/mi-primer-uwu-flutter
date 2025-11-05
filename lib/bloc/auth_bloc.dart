import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroperacionrest/bloc/auth_state.dart';
import 'auth_event.dart';
import '../firebase_auth_repo.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthRepo authRepo;

  AuthBloc(this.authRepo) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepo.signIn(event.email, event.password);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepo.register(event.email, event.password);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure("Error en el Registro: ${e.toString()}"));
      }
    });

    on<LogoutRequested>((event, emit) async {
      try {
        await authRepo.logout();
        emit(AuthInitial());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
