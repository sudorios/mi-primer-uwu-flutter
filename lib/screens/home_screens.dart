import 'package:flutter/material.dart';
// Eliminamos firebase_auth porque acordamos hacerlo "sin authorization"
import 'package:proyectobase/screens/login_screens.dart';
import 'package:proyectobase/screens/usuario.screens.dart';

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
            
            ListTile(
              leading: const Icon(Icons.person_add, color: Colors.blue),
              title: const Text('Registro Usuario'),
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UsuarioScreen(),
                  ),
                );
              },
            ),
            
            const Divider(), 

            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuración'),
            ),

            // --- BOTÓN SALIR MODIFICADO ---
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red), 
              title: const Text('Salir'),
              onTap: () {
                // 1. Cerramos el menú lateral
                Navigator.pop(context);
                
                // 2. Ya no llamamos a FirebaseAuth.instance.signOut();
                // Simplemente navegamos de vuelta al Login borrando el historial.
                
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(), 
                  ),
                  (route) => false, 
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flutter_dash, size: 100, color: Colors.lightBlue),
            SizedBox(height: 20),
            Text(
              "Bienvenidos al Examen",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("Selecciona una opción del menú"),
          ],
        ),
      ),
    );
  }
}