import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/usuario_bloc.dart';
import '../bloc/usuario_event.dart';
import '../bloc/usuario_state.dart';
import '../repositorio/api_repository.dart';
import 'home.dart';

class BuscarUsuarioPage extends StatelessWidget {
  BuscarUsuarioPage({super.key});

  final TextEditingController idController = TextEditingController();

  final Map<String, TextEditingController> controllers = {
    'firstName': TextEditingController(),
    'lastName': TextEditingController(),
    'maidenName': TextEditingController(),
    'age': TextEditingController(),
    'gender': TextEditingController(),
    'email': TextEditingController(),
    'phone': TextEditingController(),
    'username': TextEditingController(),
    'birthDate': TextEditingController(),
    'bloodGroup': TextEditingController(),
    'height': TextEditingController(),
    'weight': TextEditingController(),
    'eyeColor': TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UsuarioBloc(ApiRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Buscar Usuario por ID'),
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
        ),
        body: BlocConsumer<UsuarioBloc, UsuarioState>(
          listener: (context, state) {
            if (state is UsuarioLoadedState) {
              final usuario = state.usuario;
              controllers['firstName']!.text = usuario['firstName'] ?? '';
              controllers['lastName']!.text = usuario['lastName'] ?? '';
              controllers['maidenName']!.text = usuario['maidenName'] ?? '';
              controllers['age']!.text = usuario['age']?.toString() ?? '';
              controllers['gender']!.text = usuario['gender'] ?? '';
              controllers['email']!.text = usuario['email'] ?? '';
              controllers['phone']!.text = usuario['phone'] ?? '';
              controllers['username']!.text = usuario['username'] ?? '';
              controllers['birthDate']!.text = usuario['birthDate'] ?? '';
              controllers['bloodGroup']!.text = usuario['bloodGroup'] ?? '';
              controllers['height']!.text = usuario['height']?.toString() ?? '';
              controllers['weight']!.text = usuario['weight']?.toString() ?? '';
              controllers['eyeColor']!.text = usuario['eyeColor'] ?? '';
            }
            if (state is UsuarioGuardadoState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Usuario guardado exitosamente'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const Home()),
              );
            }
            if (state is UsuarioErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${state.message}"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            Map<String, dynamic>? usuarioActual;

            if (state is UsuarioLoadedState) {
              usuarioActual = state.usuario;
            }
            if (state is UsuarioGuardandoState) {
              usuarioActual = state.usuario;
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: idController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'ID del Usuario',
                              hintText: 'Ej: 1',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            final id = int.tryParse(idController.text);
                            if (id != null) {
                              context.read<UsuarioBloc>().add(
                                BuscarUsuarioEvent(id),
                              );
                              FocusScope.of(
                                context,
                              ).unfocus(); // Ocultar teclado
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                          child: const Text('Buscar'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    if (state is UsuarioLoadingState)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),

                    if (state is UsuarioErrorState)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (usuarioActual != null ||
                        state is UsuarioLoadedState) ...[
                      const Divider(thickness: 2),
                      const SizedBox(height: 10),
                      const Text(
                        "Datos del Usuario:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...controllers.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: TextField(
                            controller: entry.value,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: _formatLabel(entry.key),
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(15),
                        ),
                        icon: state is UsuarioGuardandoState
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.save),
                        label: Text(
                          state is UsuarioGuardandoState
                              ? 'Guardando...'
                              : 'Guardar en Firebase',
                          style: const TextStyle(fontSize: 16),
                        ),
                        onPressed: (state is UsuarioGuardandoState)
                            ? null
                            : () {
                                if (usuarioActual != null) {
                                  context.read<UsuarioBloc>().add(
                                    GuardarUsuarioFirebaseEvent(usuarioActual),
                                  );
                                }
                              },
                      ),
                      const SizedBox(height: 30), // Espacio final para scroll
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _formatLabel(String key) {
    if (key.isEmpty) return key;
    final result = key.replaceFirstMapped(
      RegExp(r'[A-Z]'),
      (match) => ' ${match.group(0)}',
    );
    return result[0].toUpperCase() + result.substring(1);
  }
}
