import 'package:flutteroperacionrest/bloc/operacion_edit_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/operacion.dart';
import '../repositorio/operacion_repository.dart';
import '../bloc/operacion_edit_event.dart';
import '../bloc/operacion_edit_state.dart';

class OperacionEditPage extends StatelessWidget {
  final Operacion operacion;
  const OperacionEditPage({super.key, required this.operacion});

  @override
  Widget build(BuildContext context) {
    final idCtrl = TextEditingController(text: operacion.idOperacion);
    final descCtrl = TextEditingController(text: operacion.descripcion);
    final cantidadCtrl = TextEditingController(
      text: operacion.cantidad.toString(),
    );
    final montoCtrl = TextEditingController(text: operacion.monto.toString());
    final responsableCtrl = TextEditingController(text: operacion.responsable);

    return BlocProvider(
      create: (_) =>
          OperacionEditBloc(OperacionRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Editar Operación'),
          backgroundColor: Colors.lightBlueAccent,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocConsumer<OperacionEditBloc, OperacionEditState>(
            listener: (context, state) {
              if (state is OperacionEditSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Operación actualizada con éxito'),
                  ),
                );
                Navigator.pop(context);
              } else if (state is OperacionEditFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.error}')),
                );
              }
            },
            builder: (context, state) {
              final isLoading = state is OperacionEditLoading;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: idCtrl,
                      decoration: const InputDecoration(
                        labelText: 'ID Operación',
                      ),
                    ),
                    TextField(
                      controller: descCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Descripción',
                      ),
                    ),
                    TextField(
                      controller: cantidadCtrl,
                      decoration: const InputDecoration(labelText: 'Cantidad'),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: montoCtrl,
                      decoration: const InputDecoration(labelText: 'Monto'),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                    TextField(
                      controller: responsableCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Responsable',
                      ),
                    ),
                    const SizedBox(height: 20),
                    isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              final idOperacion = idCtrl.text;
                              final descripcion = descCtrl.text;
                              final cantidad =
                                  int.tryParse(cantidadCtrl.text) ?? 0;
                              final monto =
                                  double.tryParse(montoCtrl.text) ?? 0.0;
                              final responsable = responsableCtrl.text;

                              context.read<OperacionEditBloc>().add(
                                OperacionEditSubmitted(
                                  docId: operacion.docId,
                                  idOperacion: idOperacion,
                                  descripcion: descripcion,
                                  cantidad: cantidad,
                                  monto: monto,
                                  responsable: responsable,
                                ),
                              );
                            },
                            child: const Text('Guardar Cambios'),
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