import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroperacionrest/bloc/operacion_edit_event.dart';
import 'package:flutteroperacionrest/bloc/operacion_edit_state.dart';
import 'package:flutteroperacionrest/repositorio/operacion_repository.dart';

class OperacionEditBloc extends Bloc<OperacionEditEvent, OperacionEditState> {
  final OperacionRepository operacionRepository;

  OperacionEditBloc(this.operacionRepository) : super(const OperacionEditInitial()) {
    on<OperacionEditSubmitted>(_onOperacionEditSubmitted);
  }

  Future<void> _onOperacionEditSubmitted(
    OperacionEditSubmitted event,
    Emitter<OperacionEditState> emit,
  ) async {
    emit(const OperacionEditLoading());
    try {
      await operacionRepository.actualizarOperacion(
        docId: event.docId,
        idOperacion: event.idOperacion,
        descripcion: event.descripcion,
        cantidad: event.cantidad,
        monto: event.monto,
        responsable: event.responsable,
      );
      emit(const OperacionEditSuccess());
    } catch (e) {
      emit(OperacionEditFailure(e.toString()));
    }
  }
}