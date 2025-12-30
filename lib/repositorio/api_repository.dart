import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiRepository {
  Future<dynamic> fetchData() async {
    try {
      final String endpoint = 'https://dummyjson.com/users'; 
      final response = await http.get(Uri.parse(endpoint));
      print(" STATUS CODE: ${response.statusCode}");
      print(" RESPONSE BODY: ${response.body}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['users'];
      } else {
        throw Exception('Error al obtener datos de la API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener datos de la API: $e');
    }
  }
  Future<Map<String, dynamic>> fetchById(int id) async {
    try {
      final String endpoint = 'https://dummyjson.com/users/$id'; 
      final response = await http.get(Uri.parse(endpoint));
      print(" STATUS CODE: ${response.statusCode}");
      print(" RESPONSE BODY: ${response.body}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Error al obtener datos de la API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al obtener datos de la API: $e');
    }
  }
}