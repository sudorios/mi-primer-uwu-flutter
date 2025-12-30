class Usuario {
  final String uid; // ID de autenticación
  final String email;
  final String nombre;
  final String apellido;
  final String dni;
  final String direccion;

  Usuario({
    required this.uid,
    required this.email,
    required this.nombre,
    required this.apellido,
    required this.dni,
    required this.direccion,
  });

  // Convertir a Mapa para guardar en Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'nombre': nombre,
      'apellido': apellido,
      'dni': dni,
      'direccion': direccion,
    };
  }

  // Crear objeto desde Firestore
  factory Usuario.fromMap(String documentId, Map<String, dynamic> map) {
    return Usuario(
      uid: documentId,
      email: map['email'] ?? '',
      nombre: map['nombre'] ?? '',
      apellido: map['apellido'] ?? '',
      dni: map['dni'] ?? '',
      direccion: map['direccion'] ?? '',
    );
  }
}
