import 'package:flutter/material.dart';

class Pregunta5AP extends StatefulWidget {
  static const String routeName = "/pregunta5ap";

  const Pregunta5AP({super.key});

  @override
  State<Pregunta5AP> createState() => _Pregunta5APState();
}

class _Pregunta5APState extends State<Pregunta5AP> {
  final TextEditingController numeroController = TextEditingController();

  void _procesarNumero(BuildContext context) {
    String texto = numeroController.text.trim();

    if (texto.length != 5 || int.tryParse(texto) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingrese un número de 5 dígitos válido')),
      );
      return;
    }

    List<int> digitos = texto.split('').map(int.parse).toList();

    int sumaPrincipal = digitos[0] + digitos[1] + digitos[4];
    int sumaPares = digitos.where((d) => d % 2 == 0).fold(0, (a, b) => a + b);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Resultado'),
        content: Text(
          'Número ingresado: $texto\n\n'
          'Suma (1er + 2do + último dígito): $sumaPrincipal\n'
          'Suma de dígitos pares: $sumaPares',
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
        title: const Text('Pregunta 5 - Sumar Dígitos'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: numeroController,
              keyboardType: TextInputType.number,
              maxLength: 5,
              decoration: const InputDecoration(
                labelText: 'Ingrese un número de 5 dígitos',
                border: OutlineInputBorder(),
                counterText: "",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _procesarNumero(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Procesar número'),
            ),
          ],
        ),
      ),
    );
  }
}