
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroperacionrest/bloc/auth_event.dart';
import 'package:flutteroperacionrest/bloc/auth_state.dart';
import 'package:flutteroperacionrest/firebase_auth_repo.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{
  //Referencia a la repo de autenticacion
  final FirebaseAuthRepo authRepo;
  //Creamos el constructor que recibe el repositorio
  AuthBloc(this.authRepo):super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try{
        //Procedemos a intentar iniciar sesion
        await authRepo.signIn(event.email, event.password);
        //Si todo sale bien emitimos exito
        emit(AuthSuccess());
      }catch(e){
        emit(AuthFailure("Login error:${e.toString()}"));
      }
    })
    ;
    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try{
        //Procedemos a intentar registrar al usuario
        await authRepo.register(event.email, event.password);
        //Si todo sale bien emitimos exito
        emit(AuthSuccess());
      }catch(e){
        emit(AuthFailure("Registro error:${e.toString()}"));
      }
    });

    //Manejamos el evento de cerrar sesion
    on<LogoutRequested>((event, emit) async {
      emit(AuthLoading());
      try{
        //Procedemos a intentar cerrar sesion
        await authRepo.logout();
        //Si todo sale bien emitimos exito
        emit(AuthSuccess());
      }catch(e){
        emit(AuthFailure("Logout error:${e.toString()}"));
      }
    });
  } 
}