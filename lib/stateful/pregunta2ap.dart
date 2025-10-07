import 'package:flutter/material.dart';

class Pregunta2AP extends StatefulWidget {
  static const String routeName = "/pregunta2ap";

  const Pregunta2AP({super.key});

  @override
  State<Pregunta2AP> createState() => _Pregunta2APState();
}

class _Pregunta2APState extends State<Pregunta2AP> {
  final TextEditingController _controller = TextEditingController();
  String _apellido = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregunta 2 - Ingreso de Apellido'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Ingrese su apellido',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (valor) {
                setState(() {
                  _apellido = valor.trim();
                });
              },
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                _apellido.isEmpty
                    ? 'Esperando ingreso...'
                    : 'Apellido ingresado: $_apellido',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
