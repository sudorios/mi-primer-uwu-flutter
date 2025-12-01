class Alumno {
  final String id;
  final String codigo;
  final String nombre;
  final String apellido;
  final String dni;
  final double nota1;
  final double nota2;
  final double nota3;
  final double nota4;
  final double promedioFinal;

  Alumno({
    required this.id,
    required this.codigo,
    required this.nombre,
    required this.apellido,
    required this.dni,
    required this.nota1,
    required this.nota2,
    required this.nota3,
    required this.nota4,
    required this.promedioFinal,
  });

  factory Alumno.fromMap(String id, Map<String, dynamic> map) {
    double n1 = (map['nota1'] ?? 0).toDouble();
    double n2 = (map['nota2'] ?? 0).toDouble();
    double n3 = (map['nota3'] ?? 0).toDouble();
    double n4 = (map['nota4'] ?? 0).toDouble();
    double prom = map['promedioFinal'] != null
        ? (map['promedioFinal']).toDouble()
        : (n1 + n2 + n3 + n4) / 4;
    return Alumno(
      id: id,
      codigo: map['codigo'] ?? '',
      nombre: map['nombre'] ?? '',
      apellido: map['apellido'] ?? '',
      dni: map['dni'] ?? '',
      nota1: n1,
      nota2: n2,
      nota3: n3,
      nota4: n4,
      promedioFinal: prom,
    );
  }
}
