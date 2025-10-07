import 'package:flutter/material.dart';

class Pregunta6AP extends StatefulWidget {
  static const String routeName = "/pregunta6ap";

  const Pregunta6AP({super.key});

  @override
  State<Pregunta6AP> createState() => _Pregunta6APState();
}

class _Pregunta6APState extends State<Pregunta6AP> {
  final TextEditingController nombreController = TextEditingController();

  void _invertirNombre(BuildContext context) {
    final texto = nombreController.text.trim();

    if (texto.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingrese un nombre válido')),
      );
      return;
    }

    // Invertir el nombre
    String invertido = texto.split('').reversed.join('');

    String primer = invertido[0].toUpperCase();
    String ultimos = invertido.length >= 2
        ? invertido.substring(invertido.length - 2).toUpperCase()
        : invertido.toUpperCase();


    String resultado = primer + invertido.substring(1, invertido.length - 2) + ultimos;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resultado'),
        content: Text(
          'Nombre original: $texto\n'
          'Nombre transformado: $resultado',
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregunta 6 - Invertir Nombre'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: 'Ingrese su nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _invertirNombre(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Invertir nombre'),
            ),
          ],
        ),
      ),
    );
  }
}
