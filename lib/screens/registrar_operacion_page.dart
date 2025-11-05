import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/operacion_bloc.dart';
import '../bloc/operacion_event.dart';
import '../bloc/operacion_state.dart';
import '../repositorio/operacion_repository.dart';

class RegistrarOperacionPage extends StatelessWidget {
  final TextEditingController idCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  final TextEditingController cantCtrl = TextEditingController();
  final TextEditingController montoCtrl = TextEditingController();
  final TextEditingController respCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OperacionBloc(OperacionRepository()),
      child: Scaffold(
        appBar: AppBar(title: Text('Registrar Operación')),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: BlocConsumer<OperacionBloc, OperacionState>(
            listener: (context, state) {
              if (state is OperacionSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Operación registrada con éxito')),
                );
              } else if (state is OperacionFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.error}')),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: idCtrl,
                      decoration: InputDecoration(labelText: 'ID Operación'),
                    ),
                    TextField(
                      controller: descCtrl,
                      decoration: InputDecoration(labelText: 'Descripción'),
                    ),
                    TextField(
                      controller: cantCtrl,
                      decoration: InputDecoration(labelText: 'Cantidad'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: montoCtrl,
                      decoration: InputDecoration(labelText: 'Monto'),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20),
                    if (state is OperacionLoading)
                      CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: () {
                          context.read<OperacionBloc>().add(
                            RegistrarOperacion(
                              idOperacion: idCtrl.text,
                              descripcion: descCtrl.text,
                              cantidad: int.tryParse(cantCtrl.text) ?? 0,
                              monto: double.tryParse(montoCtrl.text) ?? 0.0,
                              responsable: respCtrl.text,
                            ),
                          );
                        },
                        child: Text('Guardar'),
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
