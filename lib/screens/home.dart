import 'package:flutter/material.dart';
import 'package:flutteroperacionrest/screens/buscar_usuario_page.dart';
import 'package:flutteroperacionrest/screens/consumo_page.dart';
import 'package:flutteroperacionrest/screens/operacion_list_page.dart';
import 'package:flutteroperacionrest/screens/registrar_operacion_page.dart';

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
          "Página Principal",
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
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),
              child: Text(
                'Menú de opciones',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
            ),
            const ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contacto'),
            ),
            ListTile(
              leading: const Icon(Icons.factory, color: Colors.deepOrange),
              title: const Text('Operación'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OperacionListPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle, color: Colors.green),
              title: const Text('Listado Usuario'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConsumoPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person_add, color: Colors.blue),
              title: const Text('Buscar Usuario por ID'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuscarUsuarioPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          "Bienvenidos a la página principal",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
