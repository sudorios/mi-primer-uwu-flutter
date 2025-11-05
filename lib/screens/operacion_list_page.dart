import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroperacionrest/bloc/operacion_list_bloc.dart';
import 'package:flutteroperacionrest/bloc/operacion_list_event.dart';
import 'package:flutteroperacionrest/bloc/operacion_list_state.dart';
import 'package:flutteroperacionrest/repositorio/operacion_repository.dart';

class OperacionListPage extends StatelessWidget {
  const OperacionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=> 
          OperacionListBloc(OperacionRepository())
            ..add(OperacionListSubscribeEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Lista de Operaciones'),),
        body: BlocBuilder<OperacionListBloc, OperacionListState>(
          builder: (context, state) {
            if(state is OperacionListLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if(state is OperacionListError){
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('Cargando o sin datos...'));
          },
        ),
      ),
    );
  }

}