import 'package:appmovilpractica/bloc/auth/auth_event.dart';
import 'package:appmovilpractica/bloc/auth/auth_state.dart';
import 'package:appmovilpractica/repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';
import 'home.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final dniController = TextEditingController();
  final direccionController = TextEditingController();

  bool isLoginMode = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(FirebaseAuthRepo()),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const Home()),
                        );
                      } else if (state is AuthFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isLoginMode ? "Bienvenido" : "Crear Cuenta",
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // --- CAMPOS DE REGISTRO (Solo visibles en modo registro) ---
                          if (!isLoginMode) ...[
                            _buildTextField(
                              nombreController,
                              "Nombre",
                              Icons.person,
                            ),
                            const SizedBox(height: 12),
                            _buildTextField(
                              apellidoController,
                              "Apellido",
                              Icons.person_outline,
                            ),
                            const SizedBox(height: 12),
                            _buildTextField(
                              dniController,
                              "DNI",
                              Icons.badge,
                              isNumber: true,
                            ),
                            const SizedBox(height: 12),
                            _buildTextField(
                              direccionController,
                              "Dirección",
                              Icons.home,
                            ),
                            const SizedBox(height: 12),
                          ],

                          // --- CAMPOS COMUNES ---
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                isLoginMode ? Icons.person_search : Icons.email,
                              ),
                              labelText: isLoginMode
                                  ? "Correo o DNI"
                                  : "Correo Electrónico",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              labelText: "Contraseña",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // --- BOTÓN DE ACCIÓN ---
                          if (state is AuthLoading)
                            const CircularProgressIndicator()
                          else
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton.icon(
                                icon: Icon(
                                  isLoginMode
                                      ? Icons.login
                                      : Icons.app_registration,
                                ),
                                label: Text(
                                  isLoginMode
                                      ? "INICIAR SESIÓN"
                                      : "REGISTRARSE",
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isLoginMode
                                      ? Colors.blue
                                      : Colors.green,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                                onPressed: () {
                                  if (isLoginMode) {
                                    context.read<AuthBloc>().add(
                                      LoginRequested(
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                      ),
                                    );
                                  } else {
                                    context.read<AuthBloc>().add(
                                      RegisterRequested(
                                        email: emailController.text.trim(),
                                        password: passwordController.text
                                            .trim(),
                                        nombre: nombreController.text.trim(),
                                        apellido: apellidoController.text
                                            .trim(),
                                        dni: dniController.text.trim(),
                                        direccion: direccionController.text
                                            .trim(),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isLoginMode = !isLoginMode;
                              });
                            },
                            child: Text(
                              isLoginMode
                                  ? "¿No tienes cuenta? Regístrate aquí"
                                  : "¿Ya tienes cuenta? Inicia Sesión",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 10,
        ),
      ),
    );
  }
}
