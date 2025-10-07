import 'package:flutter/material.dart';

class Transit extends StatelessWidget {
  const Transit({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Vista del transporte público 🚆',
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}
