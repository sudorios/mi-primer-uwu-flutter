import 'package:appmovilpractica/bloc/alumno/alumno_bloc.dart';
import 'package:appmovilpractica/bloc/alumno/alumno_event.dart';
import 'package:appmovilpractica/bloc/alumno/alumno_state.dart';
import 'package:appmovilpractica/model/alumno.dart';
import 'package:appmovilpractica/repository/alumno_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrarAlumnoPage extends StatefulWidget {
  const RegistrarAlumnoPage({super.key});

  @override
  State<RegistrarAlumnoPage> createState() => _RegistrarAlumnoPageState();
}

class _RegistrarAlumnoPageState extends State<RegistrarAlumnoPage> {
  final _formKey = GlobalKey<FormState>();

  final codigoCtrl = TextEditingController();
  final nombreCtrl = TextEditingController();
  final apellidoCtrl = TextEditingController();
  final dniCtrl = TextEditingController();
  final n1Ctrl = TextEditingController();
  final n2Ctrl = TextEditingController();
  final n3Ctrl = TextEditingController();
  final n4Ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlumnoBloc(AlumnoRepository()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Registrar Alumno'),
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
            ),
            body: BlocListener<AlumnoBloc, AlumnoState>(
              listener: (context, state) {
                if (state is AlumnoError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.message}')),
                  );
                }
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _crearInput(codigoCtrl, 'Código'),
                      const SizedBox(height: 10),
                      _crearInput(nombreCtrl, 'Nombre'),
                      const SizedBox(height: 10),
                      _crearInput(apellidoCtrl, 'Apellido'),
                      const SizedBox(height: 10),
                      _crearInput(dniCtrl, 'DNI', numerico: true),
                      const SizedBox(height: 20),

                      const Text(
                        "Notas (0-20):",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Expanded(
                            child: _crearInput(
                              n1Ctrl,
                              'Nota 1',
                              numerico: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _crearInput(
                              n2Ctrl,
                              'Nota 2',
                              numerico: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _crearInput(
                              n3Ctrl,
                              'Nota 3',
                              numerico: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _crearInput(
                              n4Ctrl,
                              'Nota 4',
                              numerico: true,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _guardar(context);
                            }
                          },
                          child: const Text('GUARDAR'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _crearInput(
    TextEditingController ctrl,
    String label, {
    bool numerico = false,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: numerico ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return 'Requerido';
        if (numerico && double.tryParse(v) == null) return 'Inválido';
        return null;
      },
    );
  }

  void _guardar(BuildContext context) {
    final n1 = double.tryParse(n1Ctrl.text) ?? 0;
    final n2 = double.tryParse(n2Ctrl.text) ?? 0;
    final n3 = double.tryParse(n3Ctrl.text) ?? 0;
    final n4 = double.tryParse(n4Ctrl.text) ?? 0;
    final promedio = (n1 + n2 + n3 + n4) / 4;

    final alumno = Alumno(
      id: '',
      codigo: codigoCtrl.text,
      nombre: nombreCtrl.text,
      apellido: apellidoCtrl.text,
      dni: dniCtrl.text,
      nota1: n1,
      nota2: n2,
      nota3: n3,
      nota4: n4,
      promedioFinal: promedio,
    );

    context.read<AlumnoBloc>().add(AddAlumno(alumno));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alumno registrado exitosamente')),
    );
    Navigator.pop(context);
  }
}
