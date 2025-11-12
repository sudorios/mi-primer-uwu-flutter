import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroperacionrest/bloc/operacion_list_event.dart';
import 'package:flutteroperacionrest/bloc/operacion_list_state.dart';
import 'package:flutteroperacionrest/model/operacion.dart';
import 'package:flutteroperacionrest/repositorio/operacion_repository.dart';

class OperacionListBloc extends Bloc<OperacionListEvent, OperacionListState>{
  final OperacionRepository operacionRepository;
  OperacionListBloc(this.operacionRepository):super(const OperacionListLoading()) {
    on<OperacionListSubscribeEvent>(_onSuscribe);
  }
  Future<void> _onSuscribe(
    OperacionListSubscribeEvent event,
    Emitter<OperacionListState> emit,
  ) async {
    emit(const OperacionListLoading());
    await emit.forEach<List<Operacion>>(
      operacionRepository.streamOperaciones(),
      onData: (operaciones) => OperacionListLoaded(operaciones),
      onError: (error, stackTrace) => OperacionListError(error.toString()),
    );
  }
}
