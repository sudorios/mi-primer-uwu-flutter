import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroperacionrest/bloc/operacion_delete_event.dart';
import 'package:flutteroperacionrest/bloc/operacion_delete_state.dart';
import 'package:flutteroperacionrest/repositorio/operacion_repository.dart';

class OperacionDeleteBloc extends Bloc<OperacionDeleteEvent, OperacionDeleteState> {
  final OperacionRepository operacionRepository;

  OperacionDeleteBloc(this.operacionRepository) : super(OperacionDeleteInitial()) {
    on<OperacionDeleteRequest>(_onOperacionDeleteRequest);
  }

  Future<void> _onOperacionDeleteRequest(
    OperacionDeleteRequest event,
    Emitter<OperacionDeleteState> emit,
  ) async {
    emit(OperacionDeleteLoading());
    try {
      await operacionRepository.eliminarOperacion(event.docId);
      emit(OperacionDeleteSuccess());
    } catch (e) {
      emit(OperacionDeleteFailure(e.toString()));
    }
  }
}