import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroperacionrest/bloc/operacion_detalle_bloc.dart';
import 'package:flutteroperacionrest/bloc/operacion_detalle_event.dart';
import 'package:flutteroperacionrest/bloc/operacion_detalle_state.dart';
import 'package:flutteroperacionrest/repositorio/operacion_repository.dart';

class OperacionDetallePage extends StatelessWidget {
  final String docId;

  const OperacionDetallePage({super.key, required this.docId});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          OperacionDetalleBloc(OperacionRepository())
            ..add(CargarOperacionDetalle(docId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detalle de Operacion'),
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<OperacionDetalleBloc, OperacionDetalleState>(
          builder: (context, state) {
            if (state is OperacionDetalleLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is OperacionDetalleError) {
              return Center(child: Text('Error: ${state.error}'));
            }
            if (state is OperacionDetalleLoaded) {
              final op = state.operacion;
              final fechaTxt = op.fecha != null
                  ? '${op.fecha!.day}/${op.fecha!.month}/${op.fecha!.year}'
                  : 'N/A';
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID Operacion: ${op.idOperacion}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Descripcion: ${op.descripcion}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Cantidad: ${op.cantidad}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Monto: ${op.monto.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Responsable: ${op.responsable}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Fecha: $fechaTxt',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(icon: const Icon(Icons.arrow_back), label: const Text('Volver'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              );
            }
            return const Center(child: Text('Sin datos disponibles.'));
          },
        ),
      ),
    );
  }
}
