import 'package:appmovilpractica/model/alumno.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlumnoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Alumno>> getAlumnos() {
    return _firestore.collection('alumnos').orderBy('apellido').snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return Alumno.fromMap(doc.id, doc.data());
        }).toList();
      },
    );
  }

  Future<void> addAlumno(Alumno alumno) async {
    await _firestore.collection('alumnos').add({
      'codigo': alumno.codigo,
      'nombre': alumno.nombre,
      'apellido': alumno.apellido,
      'dni': alumno.dni,
      'nota1': alumno.nota1,
      'nota2': alumno.nota2,
      'nota3': alumno.nota3,
      'nota4': alumno.nota4,
      'promedioFinal': alumno.promedioFinal,
    });
  }

  Future<void> updateAlumno(Alumno alumno) async {
    await _firestore.collection('alumnos').doc(alumno.id).update({
      'codigo': alumno.codigo,
      'nombre': alumno.nombre,
      'apellido': alumno.apellido,
      'dni': alumno.dni,
      'nota1': alumno.nota1,
      'nota2': alumno.nota2,
      'nota3': alumno.nota3,
      'nota4': alumno.nota4,
      'promedioFinal': alumno.promedioFinal,
    });
  }

  Future<void> deleteAlumno(String id) async {
    await _firestore.collection('alumnos').doc(id).delete();
  }
}
