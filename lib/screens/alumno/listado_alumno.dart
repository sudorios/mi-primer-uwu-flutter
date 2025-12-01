import 'package:appmovilpractica/bloc/alumno/alumno_bloc.dart';
import 'package:appmovilpractica/bloc/alumno/alumno_event.dart';
import 'package:appmovilpractica/bloc/alumno/alumno_state.dart';
import 'package:appmovilpractica/model/alumno.dart';
import 'package:appmovilpractica/repository/alumno_repo.dart';
import 'package:appmovilpractica/screens/alumno/detalle_alumno.dart';
import 'package:appmovilpractica/screens/alumno/edit_alumno.dart';
import 'package:appmovilpractica/screens/alumno/registrar_alumno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListadoAlumnosPage extends StatelessWidget {
  const ListadoAlumnosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlumnoBloc(AlumnoRepository())..add(LoadAlumnos()),
      child: const AlumnoView(),
    );
  }
}

class AlumnoView extends StatelessWidget {
  const AlumnoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestión de Alumnos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RegistrarAlumnoPage()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<AlumnoBloc, AlumnoState>(
        builder: (context, state) {
          if (state is AlumnoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlumnoLoaded) {
            final alumnos = state.alumnos;

            if (alumnos.isEmpty) {
              return const Center(child: Text("No hay alumnos registrados."));
            }

            return ListView.separated(
              itemCount: alumnos.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, i) => _AlumnoTile(
                alumno: alumnos[i],
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditarAlumnoPage(alumno: alumnos[i]),
                    ),
                  );
                },
                onDelete: () => _confirmarEliminacion(context, alumnos[i]),
                onView: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetalleAlumnoPage(alumno: alumnos[i]),
                    ),
                  );
                },
              ),
            );
          } else if (state is AlumnoError) {
            return Center(child: Text("Error: ${state.message}"));
          }
          return const Center(child: Text("Cargando..."));
        },
      ),
    );
  }

  void _confirmarEliminacion(BuildContext context, Alumno alumno) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Eliminar"),
        content: Text("¿Eliminar a ${alumno.nombre}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              context.read<AlumnoBloc>().add(DeleteAlumno(alumno.id));
              Navigator.pop(ctx);
            },
            child: const Text("Eliminar"),
          ),
        ],
      ),
    );
  }
}

class _AlumnoTile extends StatelessWidget {
  final Alumno alumno;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onView;

  const _AlumnoTile({
    required this.alumno,
    required this.onEdit,
    required this.onDelete,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: Text('${alumno.apellido}, ${alumno.nombre}'),
      subtitle: Text('Promedio: ${alumno.promedioFinal}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: const Icon(Icons.visibility), onPressed: onView),
          IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
          IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
        ],
      ),
      onTap: onView,
    );
  }
}
