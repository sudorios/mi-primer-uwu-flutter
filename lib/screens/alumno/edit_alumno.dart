import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appmovilpractica/bloc/alumno/alumno_bloc.dart';
import 'package:appmovilpractica/bloc/alumno/alumno_event.dart';
import 'package:appmovilpractica/bloc/alumno/alumno_state.dart';
import 'package:appmovilpractica/model/alumno.dart';
import 'package:appmovilpractica/repository/alumno_repo.dart';

class EditarAlumnoPage extends StatefulWidget {
  final Alumno alumno;
  const EditarAlumnoPage({super.key, required this.alumno});

  @override
  State<EditarAlumnoPage> createState() => _EditarAlumnoPageState();
}

class _EditarAlumnoPageState extends State<EditarAlumnoPage> {
  late TextEditingController codigoCtrl;
  late TextEditingController nombreCtrl;
  late TextEditingController apellidoCtrl;
  late TextEditingController dniCtrl;
  late TextEditingController n1Ctrl;
  late TextEditingController n2Ctrl;
  late TextEditingController n3Ctrl;
  late TextEditingController n4Ctrl;

  @override
  void initState() {
    super.initState();
    codigoCtrl = TextEditingController(text: widget.alumno.codigo);
    nombreCtrl = TextEditingController(text: widget.alumno.nombre);
    apellidoCtrl = TextEditingController(text: widget.alumno.apellido);
    dniCtrl = TextEditingController(text: widget.alumno.dni);
    n1Ctrl = TextEditingController(text: widget.alumno.nota1.toString());
    n2Ctrl = TextEditingController(text: widget.alumno.nota2.toString());
    n3Ctrl = TextEditingController(text: widget.alumno.nota3.toString());
    n4Ctrl = TextEditingController(text: widget.alumno.nota4.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlumnoBloc(AlumnoRepository()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Editar Alumno')),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<AlumnoBloc, AlumnoState>(
            listener: (context, state) {
              if (state is AlumnoSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Actualizado correctamente')),
                );
                Navigator.pop(context); 
              } else if (state is AlumnoError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: codigoCtrl,
                      decoration: const InputDecoration(labelText: 'Código'),
                    ),
                    TextField(
                      controller: nombreCtrl,
                      decoration: const InputDecoration(labelText: 'Nombre'),
                    ),
                    TextField(
                      controller: apellidoCtrl,
                      decoration: const InputDecoration(labelText: 'Apellido'),
                    ),
                    TextField(
                      controller: dniCtrl,
                      decoration: const InputDecoration(labelText: 'DNI'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Notas",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: n1Ctrl,
                      decoration: const InputDecoration(labelText: 'Nota 1'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: n2Ctrl,
                      decoration: const InputDecoration(labelText: 'Nota 2'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: n3Ctrl,
                      decoration: const InputDecoration(labelText: 'Nota 3'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: n4Ctrl,
                      decoration: const InputDecoration(labelText: 'Nota 4'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    if (state is AlumnoLoading)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: () {
                          final n1 = double.tryParse(n1Ctrl.text) ?? 0;
                          final n2 = double.tryParse(n2Ctrl.text) ?? 0;
                          final n3 = double.tryParse(n3Ctrl.text) ?? 0;
                          final n4 = double.tryParse(n4Ctrl.text) ?? 0;
                          final promedio = (n1 + n2 + n3 + n4) / 4;
                          context.read<AlumnoBloc>().add(
                            UpdateAlumno(
                              Alumno(
                                id: widget.alumno.id,
                                codigo: codigoCtrl.text,
                                nombre: nombreCtrl.text,
                                apellido: apellidoCtrl.text,
                                dni: dniCtrl.text,
                                nota1: n1,
                                nota2: n2,
                                nota3: n3,
                                nota4: n4,
                                promedioFinal: promedio,
                              ),
                            ),
                          );
                        },
                        child: const Text("Actualizar"),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
