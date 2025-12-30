import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> fetchUserFromApi(String id) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'nombre': data['title'].toString().split(' ')[0],
        'apellido': 'ApellidoDelPost$id',
        'dni': (10000000 + int.parse(id)).toString(),
        'email': 'usuario$id@ejemplo.com',
        'password': 'pass$id',
      };
    } else {
      throw Exception('Error al buscar el ID en la API');
    }
  }
  Future<void> saveUserToFirebase(Map<String, dynamic> userData) async {
    await _firestore.collection('usuarios').add(userData);
  }
}
