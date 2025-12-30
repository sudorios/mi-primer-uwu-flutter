import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroperacionrest/bloc/operacion_delete_bloc.dart';
import 'package:flutteroperacionrest/bloc/operacion_delete_event.dart';
import 'package:flutteroperacionrest/bloc/operacion_delete_state.dart';
import 'package:flutteroperacionrest/model/operacion.dart';
import 'package:flutteroperacionrest/repositorio/operacion_repository.dart';

class OperacionDeletePage extends StatelessWidget {
  final Operacion operacion;

  const OperacionDeletePage({super.key, required this.operacion});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OperacionDeleteBloc(OperacionRepository()),
      child: BlocListener<OperacionDeleteBloc, OperacionDeleteState>(
        listener: (context, state) {
          if (state is OperacionDeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Operación eliminada con éxito')),
            );
            Navigator.pop(context, true);
          } else if (state is OperacionDeleteFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error al eliminar: ${state.error}')),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Eliminar Operación'),
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿Estás seguro de que deseas eliminar la operación "${operacion.descripcion}"?',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Detalles de la operación',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Divider(),
                          const SizedBox(height: 10),
                          Text('ID: ${operacion.idOperacion}'),
                          const SizedBox(height: 5),
                          Text('Descripción: ${operacion.descripcion}'),
                          const SizedBox(height: 5),
                          Text('Monto: S/ ${operacion.monto.toStringAsFixed(2)}'),
                          const SizedBox(height: 5),
                          Text('Fecha: ${operacion.fecha}'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<OperacionDeleteBloc, OperacionDeleteState>(
                    builder: (context, state) {
                      if (state is OperacionDeleteLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              icon: const Icon(Icons.delete),
                              label: const Text('Eliminar definitivamente'),
                              onPressed: () {
                                context.read<OperacionDeleteBloc>().add(
                                      OperacionDeleteRequest(
                                          operacion.docId),
                                    );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancelar'),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}