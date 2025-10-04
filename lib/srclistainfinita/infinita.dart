import 'dart:math';
import 'package:flutter/material.dart';

class Infinita extends StatefulWidget {
  @override
  static const String routeName = '/infinita';
  _InfinitaState createState() => _InfinitaState();
}

class _InfinitaState extends State<Infinita> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista Infinita',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue,
        shadowColor: Colors.grey,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Item $index'), //tomamos numeros aleatorios
            subtitle: Text('Precio:  ${Random().nextInt(500)} USD'),
          );
        },
      ),
    );
  }
}
