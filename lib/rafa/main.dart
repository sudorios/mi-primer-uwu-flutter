import 'package:appmovilfirebasecuartoexamen/screen/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AppMovilFirebaseAPTercerExamen());
}

class AppMovilFirebaseAPTercerExamen extends StatelessWidget {
  const AppMovilFirebaseAPTercerExamen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen Firebase Bloc',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: AuthPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
