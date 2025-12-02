import 'package:appbase/bloc/auth/auth_event.dart';
import 'package:appbase/bloc/auth/auth_state.dart';
import 'package:appbase/bloc/repository/auth_repo.dart';
import 'package:appbase/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final dniController = TextEditingController();
  final direccionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(FirebaseAuthRepo()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Registro")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const Home()),
                  (route) => false,
                );
              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error), backgroundColor: Colors.red),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView(
                children: [
                  TextField(
                    controller: nombreController,
                    decoration: const InputDecoration(labelText: "Nombre"),
                  ),
                  TextField(
                    controller: apellidoController,
                    decoration: const InputDecoration(labelText: "Apellido"),
                  ),
                  TextField(
                    controller: dniController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "DNI"),
                  ),
                  TextField(
                    controller: direccionController,
                    decoration: const InputDecoration(labelText: "Dirección"),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: "Correo"),
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Contraseña"),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            RegisterRequested(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              nombre: nombreController.text.trim(),
                              apellido: apellidoController.text.trim(),
                              dni: dniController.text.trim(),
                              direccion: direccionController.text.trim(),
                            ),
                          );
                    },
                    child: const Text("REGISTRARME"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}