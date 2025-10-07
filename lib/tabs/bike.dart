import 'package:flutter/material.dart';

class Bike extends StatelessWidget {
  const Bike({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Vista de la bicicleta 🚴',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}
