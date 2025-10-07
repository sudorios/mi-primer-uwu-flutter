import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pagina Principal",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 4,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),
              child: Text(
                'Menu de opciones',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(leading: Icon(Icons.home), title: Text('Inicio')),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contacto'),
            ),
          ],
        ),
      ),
      body: const SizedBox.expand(
        child: Center(
          child: Text(
            "Bienvenidos a la pagina principal",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
