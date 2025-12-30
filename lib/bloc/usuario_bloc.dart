import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroperacionrest/bloc/usuario_event.dart';
import 'package:flutteroperacionrest/bloc/usuario_state.dart';
import 'package:flutteroperacionrest/repositorio/api_repository.dart';
import 'package:flutteroperacionrest/repositorio/firebase_user_repository.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState> {
  final ApiRepository apiRepository;
  final FirebaseUserRepository firebaseRepository = FirebaseUserRepository();
  UsuarioBloc(this.apiRepository) : super(UsuarioInitialState()) {
    on<BuscarUsuarioEvent>((event, emit) async {
      emit(UsuarioLoadingState());
      try {
        final usuario = await apiRepository.fetchById(event.id);
        emit(UsuarioLoadedState(usuario));
      } catch (e) {
        emit(UsuarioErrorState(e.toString()));
      }
    });
    on<GuardarUsuarioFirebaseEvent>((_guardarUsuarioFirebase));
    on<LimpiarUsuarioEvent>(_limpiar);        
  }
  Future<void> _guardarUsuarioFirebase(GuardarUsuarioFirebaseEvent event, Emitter<UsuarioState> emit) async {
    emit(UsuarioLoadingState());
    try {
      emit(UsuarioGuardandoState(event.usuario));
      await firebaseRepository.guardarUsuario(event.usuario);
      emit(UsuarioGuardadoState());
    } catch (e) {
      emit(UsuarioErrorState(e.toString()));
    }
  }
  void _limpiar(LimpiarUsuarioEvent event, Emitter<UsuarioState> emit) {
    emit(UsuarioInitialState());
  }
}
