import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroperacionrest/bloc/login_bloc.dart';
import 'package:flutteroperacionrest/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Ocultamos la pantalla de debug en la esquina
      debugShowCheckedModeBanner: false,
      title: 'Login Bloc',
      //Envolvemos la pantalla del dispositivo
      home: BlocProvider(
        //Creamos la instancia del patron bloc
        create: (_) => LoginBloc(),
        //Llamamos a la panatalla de login
        child: const LoginScreen(),
      ),
    );
    //Ocultamos la pantalla de debug en la esquina
  }
}
