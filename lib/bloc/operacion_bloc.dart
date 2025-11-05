import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroperacionrest/bloc/operacion_event.dart';
import 'package:flutteroperacionrest/bloc/operacion_state.dart';
import 'package:flutteroperacionrest/repositorio/operacion_repository.dart';

class OperacionBloc extends Bloc<OperacionEvent, OperacionState>{
  final OperacionRepository repo;
  OperacionBloc(this.repo):super(OperacionInitial()){
    on<RegistrarOperacion>((event, emit)async{
      emit(OperacionLoading());
      try{
        await repo.registrarOperacion(
          idOperacion: event.idOperacion,
          descripcion: event.descripcion,
          cantidad: event.cantidad,
          monto: event.monto,
          responsable: event.responsable,
        );
        emit(OperacionSuccess());
      }catch(e){
        emit(OperacionFailure(e.toString()));
      }
    });
  }
}