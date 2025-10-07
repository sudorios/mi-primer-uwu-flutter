import 'package:flutter/material.dart';

class Pregunta4AP extends StatelessWidget {
  static const String routeName = "/pregunta4ap";

  const Pregunta4AP({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nombreController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregunta 4 - AlertDialog'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              onPressed: () {
                final nombre = nombreController.text.trim();

                if (nombre.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor, ingrese su nombre')),
                  );
                  return;
                }

                final primera = nombre[0];
                final ultima = nombre[nombre.length - 1];

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Resultado'),
                      content: Text(
                        'Primera letra: $primera\nÚltima letra: $ultima',
                        style: const TextStyle(fontSize: 18),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cerrar'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text('Mostrar letras'),
            ),
          ],
        ),
      ),
    );
  }
}
