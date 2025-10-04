import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  static const String routeName = '/configuracion';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Configuracion',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue,
        shadowColor: Colors.grey,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(child: Center(child: Text('Pantalla de configuración'))),
    );
  }
}
