import 'package:appmovilpractica/model/alumno.dart';

abstract class AlumnoEvent {}

class LoadAlumnos extends AlumnoEvent {}

class UpdateAlumnosList extends AlumnoEvent {
  final List<Alumno> alumnos;
  UpdateAlumnosList(this.alumnos);
}

class AddAlumno extends AlumnoEvent {
  final Alumno alumno;
  AddAlumno(this.alumno);
}

class UpdateAlumno extends AlumnoEvent {
  final Alumno alumno;
  UpdateAlumno(this.alumno);
}

class DeleteAlumno extends AlumnoEvent {
  final String id;
  DeleteAlumno(this.id);
}