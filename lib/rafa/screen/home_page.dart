import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.lightBlue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Menú de opciones',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    user?.email ?? '',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const ListTile(leading: Icon(Icons.home), title: Text('Inicio')),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
            ),
            const ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contacto'),
            ),
            const Divider(),
            /* ListTile(
              leading: const Icon(Icons.list_alt, color: Colors.deepOrange),
              title: const Text('Listado Alumnos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListadoAlumnosPage(),
                  ),
                );
              },
            ),*/
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text('Cerrar Sesión'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_outlined, size: 100, color: Colors.lightBlue),
            SizedBox(height: 20),
            Text(
              "Bienvenidos a la App Escolar",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Seleccione 'Listado Alumnos' en el menú"),
          ],
        ),
      ),
    );
  }
}
