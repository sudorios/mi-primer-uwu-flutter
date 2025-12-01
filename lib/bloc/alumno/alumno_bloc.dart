import 'package:appmovilpractica/bloc/alumno/alumno_event.dart';
import 'package:appmovilpractica/bloc/alumno/alumno_state.dart';
import 'package:appmovilpractica/repository/alumno_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlumnoBloc extends Bloc<AlumnoEvent, AlumnoState> {
  final AlumnoRepository _repository;
  
  AlumnoBloc(this._repository) : super(AlumnoInitial()) {
    on<LoadAlumnos>((event, emit) {
      emit(AlumnoLoading());
      try {
        _repository.getAlumnos().listen((alumnos) {
          add(UpdateAlumnosList(alumnos));
        });
      } catch (e) {
        emit(AlumnoError(e.toString()));
      }
    });

    on<UpdateAlumnosList>((event, emit) {
      emit(AlumnoLoaded(event.alumnos));
    });

    on<AddAlumno>((event, emit) async {
      try {
        await _repository.addAlumno(event.alumno);
      } catch (e) {
          // Manejar error
      }
    });

    on<UpdateAlumno>((event, emit) async {
      try {
        await _repository.updateAlumno(event.alumno);
      } catch (e) {
         // Manejar error
      }
    });

    on<DeleteAlumno>((event, emit) async {
      try {
        await _repository.deleteAlumno(event.id);
      } catch (e) {
         // Manejar error
      }
    });
  }
}