import 'package:flutter/material.dart';

class Pregunta1AP extends StatelessWidget {
  static const String routeName = "/pregunta1ap";

  const Pregunta1AP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregunta 1 - MyCard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Card(
          elevation: 8,
          margin: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.alternate_email, color: Colors.blue, size: 40),
                Icon(Icons.attach_email, color: Colors.green, size: 40),
                Icon(Icons.archive_sharp, color: Colors.orange, size: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
