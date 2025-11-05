import 'package:flutter/material.dart';
import 'dart:math';

class Infinita extends StatefulWidget {
  static const String routeName = '/infinita';
  @override
  _InfinitaState createState() => _InfinitaState();
}

class _InfinitaState extends State<Infinita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lista de Productos",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlueAccent,
        shadowColor: Colors.grey,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 4,
      ),
      body: ListView.builder(
        itemBuilder: (context, i) {
          return ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Producto $i'),
            subtitle: Text('Precio: ${Random().nextInt(500)} USD'),
          );
        },
      ),
    );
  }
}
