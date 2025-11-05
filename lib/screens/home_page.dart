import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutteroperacionrest/screens/registrar_operacion_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   final user = FirebaseAuth.instance.currentUser;
   return Scaffold(
    appBar: AppBar(
      title: Text("Inicio"),
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pop(context); 
          },
        )
      ],
    ),
    body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0196F3), Color(0xFF9C27B0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )
      ),
      child: Center(
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          margin: EdgeInsets.all(24.0),
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified_user, size: 100, color: Colors.green,),
              SizedBox(height: 20),
              Text(
                'Bienvenido',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                user?.email?? 'Usuario',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> RegistrarOperacionPage()));
              }, 
              icon: Icon(Icons.add_circle),
              label: Text('Registrar Operación'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              textStyle: TextStyle(fontSize: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              )
          ))],
          )),
        )
      ),
    ),
   );
   /* return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bienvenidos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        shadowColor: Colors.grey,
      ),
      body: Center(child: Text('Bienvenido a la página principal')),
    );*/

  }
}
