import 'package:flutter/material.dart';
import 'package:appepexamenpo/utils/utils.dart';

class Metodo extends StatefulWidget {
  static const String routeName = '/utils';

  const Metodo({super.key});

  @override
  State<Metodo> createState() => _Metodo();
}

class _Metodo extends State<Metodo> {
  final TextEditingController _controller = TextEditingController();

  String _resultado = '';

  void _ejecutarMetodo() {
    String input = _controller.text.trim();

    try {
      int numero = int.tryParse(input) ?? 0;
      int result = Utils.factorial(numero);

      _mostrarDialog(' $result');
    } catch (e) {
      _mostrarDialog('Error: ${e.toString()}');
    }
  }

  void _mostrarDialog(String mensaje) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Resultado'),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Utils Screen',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Ingresa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _ejecutarMetodo,
              child: const Text('Ejecutar método'),
            ),
          ],
        ),
      ),
    );
  }
}
