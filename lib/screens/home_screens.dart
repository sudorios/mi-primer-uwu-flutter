import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
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

            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red), 
              title: const Text('Salir'),
              onTap: () {
                Navigator.pop(context);
                
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
      body: const Center(),
    );
  }
}