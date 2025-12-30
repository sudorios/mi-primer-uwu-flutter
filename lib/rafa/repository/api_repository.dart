import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiRepository {
  final String baseUrl = 'https://dummyjson.com/users';
  Future<Map<String, dynamic>?> fetchUserById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error al obtener usuario: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
