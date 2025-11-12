import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroperacionrest/bloc/operacion_list_bloc.dart';
import 'package:flutteroperacionrest/bloc/operacion_list_event.dart';
import 'package:flutteroperacionrest/bloc/operacion_list_state.dart';
import 'package:flutteroperacionrest/model/operacion.dart';
import 'package:flutteroperacionrest/repositorio/operacion_repository.dart';
import 'package:flutteroperacionrest/screens/operacion_detalle_page.dart';
import 'package:flutteroperacionrest/screens/registrar_operacion_page.dart';

class OperacionListPage extends StatelessWidget {
  const OperacionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          OperacionListBloc(OperacionRepository())
            ..add(OperacionListSubscribeEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Operaciones'),
          backgroundColor: Colors.lightBlue,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Registrar Operacion',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegistrarOperacionPage()),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<OperacionListBloc, OperacionListState>(
          builder: (context, state) {
            if (state is OperacionListLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is OperacionListError) {
              return Center(child: Text('Error: ${state.error}'));
            }

            final ops = (state as OperacionListLoaded).operaciones;
            if (ops.isEmpty) {
              return const Center(child: Text('Sin datos...'));
            }
            return ListView.separated(
              itemCount: ops.length,
              separatorBuilder: (_, __) => const Divider(height: 3),
              itemBuilder: (_, i) => _OperacionTitle(op: ops[i]),
            );
          },
        ),
      ),
    );
  }
}

class _OperacionTitle extends StatelessWidget {
  final Operacion op;
  const _OperacionTitle({required this.op});
  @override
  Widget build(BuildContext context) {
    final fechaTxt = op.fecha != null
        ? op.fecha!.toLocal().toString().substring(0, 19)
        : '-';
    return ListTile(
      leading: const Icon(Icons.factory),
      title: Text('ID: ${op.idOperacion} . ${op.descripcion}'),
      subtitle: Text(
        'Cantidad: ${op.cantidad} - Monto: ${op.monto.toStringAsFixed(2)} \nResp: ${op.responsable} - Fecha: $fechaTxt',
      ),
      trailing: SizedBox(
        width: 123,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: "Edit",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OperacionDetallePage(docId: op.docId),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: "Delete",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OperacionDetallePage(docId: op.docId),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.visibility),
              tooltip: "Detalle",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OperacionDetallePage(docId: op.docId),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
