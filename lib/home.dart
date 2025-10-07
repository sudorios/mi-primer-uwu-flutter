import 'package:appepexamenpo/srclistainfinita/infinita.dart';
import 'package:appepexamenpo/stateful/pregunta2ap.dart';
import 'package:appepexamenpo/stateful/pregunta3ap.dart';
import 'package:appepexamenpo/stateful/pregunta4ap.dart';
import 'package:appepexamenpo/stateful/pregunta5ap.dart';
import 'package:appepexamenpo/stateful/pregunta6ap.dart';
import 'package:appepexamenpo/stateful/screen.dart';
import 'package:appepexamenpo/stateless/pregunta1ap.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú Principal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Pregunta1AP.routeName),
              child: const Text('Ir a Pregunta 1 (MyCard)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, Pregunta2AP.routeName),
              child: const Text('Ir a Pregunta 2 (Apellido)'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, Pregunta3AP.routeName),
              child: const Text('Pregunta 3 - TabBar'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, Pregunta4AP.routeName),
              child: const Text('Pregunta 4 - TabBar'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, Pregunta5AP.routeName),
              child: const Text('Pregunta 5 - TabBar'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, Pregunta6AP.routeName),
              child: const Text('Pregunta 6 - TabBar'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Infinita.routeName),
              child: const Text('Lista Infinita'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Metodo.routeName),
              child: const Text('Metodos'),
            ),
          ],
        ),
      ),
    );
  }
}
