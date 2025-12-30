import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectobase/bloc/user.bloc.dart';
import 'package:proyectobase/bloc/user.event.dart';
import 'package:proyectobase/bloc/user.state.dart';

class UsuarioScreen extends StatefulWidget {
  const UsuarioScreen({super.key});

  @override
  State<UsuarioScreen> createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  final _idController = TextEditingController();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _dniController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  DateTime _fechaRegistro = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsuarioBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("ApplyWillFirebaseAPTercerExamen")),
        body: BlocConsumer<UsuarioBloc, UsuarioState>(
          listener: (context, state) {
            if (state is UsuarioLoadedState) {
              _nombreController.text = state.usuario['nombre'];
              _apellidoController.text = state.usuario['apellido'];
              _dniController.text = state.usuario['dni'];
              _emailController.text = state.usuario['email'];
              _passwordController.text = state.usuario['password'];
            } else if (state is UsuarioGuardadoState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Guardado exitoso'),
                  backgroundColor: Colors.green,
                ),
              );
              _limpiarFormulario();
            } else if (state is UsuarioErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _idController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'ID (API)',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          if (_idController.text.isNotEmpty) {
                            context.read<UsuarioBloc>().add(
                                  BuscarUsuarioEvent(_idController.text),
                                );
                          }
                        },
                      ),
                    ],
                  ),
                  if (state is UsuarioLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                  TextField(
                    controller: _apellidoController,
                    decoration: const InputDecoration(labelText: 'Apellido'),
                  ),
                  TextField(
                    controller: _dniController,
                    decoration: const InputDecoration(labelText: 'DNI'),
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Fecha: ${_fechaRegistro.day}/${_fechaRegistro.month}/${_fechaRegistro.year}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Clave de desbloqueo futura: ${_fechaRegistro.year}",
                              style: const TextStyle(
                                  color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today, color: Colors.blue),
                          onPressed: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: _fechaRegistro,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null && picked != _fechaRegistro) {
                              setState(() {
                                _fechaRegistro = picked;
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: (state is UsuarioGuardandoState)
                        ? null
                        : () {
                            final mapUser = {
                              'nombre': _nombreController.text,
                              'apellido': _apellidoController.text,
                              'dni': _dniController.text,
                              'email': _emailController.text,
                              'password': _passwordController.text,
                              // 3. ENVIAMOS LA FECHA SELECCIONADA
                              'fecha_registro': _fechaRegistro,
                            };
                            context.read<UsuarioBloc>().add(
                                  GuardarUsuarioEvent(mapUser),
                                );
                          },
                    child: const Text("GUARDAR EN FIREBASE"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _limpiarFormulario() {
    _idController.clear();
    _nombreController.clear();
    _apellidoController.clear();
    _dniController.clear();
    _emailController.clear();
    _passwordController.clear();
    setState(() {
      _fechaRegistro = DateTime.now();
    });
  }
}