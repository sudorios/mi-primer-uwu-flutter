import 'package:appmovilpractica/model/alumno.dart';

abstract class AlumnoState {}

class AlumnoInitial extends AlumnoState {}

class AlumnoLoading extends AlumnoState {}

class AlumnoSuccess extends AlumnoState {}

class AlumnoLoaded extends AlumnoState {
  final List<Alumno> alumnos;
  AlumnoLoaded(this.alumnos);
}

class AlumnoError extends AlumnoState {
  final String message;
  AlumnoError(this.message);
}