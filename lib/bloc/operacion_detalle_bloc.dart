import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositorio/operacion_repository.dart';
import 'operacion_detalle_event.dart';
import 'operacion_detalle_state.dart';

class OperacionDetalleBloc
    extends Bloc<OperacionDetalleEvent, OperacionDetalleState> {
  final OperacionRepository repo;

  OperacionDetalleBloc(this.repo) : super(OperacionDetalleLoading()) {
    on<CargarOperacionDetalle>(_onCargar);
  }

  Future<void> _onCargar(
    CargarOperacionDetalle event,
    Emitter<OperacionDetalleState> emit,
  ) async {
    emit(OperacionDetalleLoading());
    try {
      final op = await repo.getById(event.docId);
      emit(OperacionDetalleLoaded(op));
    } catch (e) {
      emit(OperacionDetalleError(e.toString()));
    }
  }
}