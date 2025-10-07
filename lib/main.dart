import 'package:appepexamenpo/bloc/login_bloc.dart';
import 'package:appepexamenpo/home1.dart';
import 'package:appepexamenpo/home.dart';
import 'package:appepexamenpo/srclistainfinita/infinita.dart';
import 'package:appepexamenpo/stateful/pregunta2ap.dart';
import 'package:appepexamenpo/stateful/pregunta3ap.dart';
import 'package:appepexamenpo/stateful/pregunta4ap.dart';
import 'package:appepexamenpo/stateful/pregunta5ap.dart';
import 'package:appepexamenpo/stateful/pregunta6ap.dart';
import 'package:appepexamenpo/stateful/screen.dart';
import 'package:appepexamenpo/stateless/pregunta1ap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screen/login_screen.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final bool showLogin = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        home: showLogin ? const LoginScreen() : const Home(),

        routes: <String, WidgetBuilder>{
          Home.routeName: (BuildContext context) => const Home(),
          Pregunta1AP.routeName: (BuildContext context) => const Pregunta1AP(),
          Pregunta2AP.routeName: (BuildContext context) => const Pregunta2AP(),
          Pregunta3AP.routeName: (BuildContext context) => const Pregunta3AP(),
          Pregunta4AP.routeName: (BuildContext context) => const Pregunta4AP(),
          Pregunta5AP.routeName: (BuildContext context) => const Pregunta5AP(),
          Pregunta6AP.routeName: (BuildContext context) => const Pregunta6AP(),
          Infinita.routeName: (BuildContext context) => Infinita(),
          Metodo.routeName: (BuildContext context) => Metodo(),
        },
      ),
    );
  }
}
