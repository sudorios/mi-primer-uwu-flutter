import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroperacionrest/bloc/api_bloc.dart';
import 'package:flutteroperacionrest/bloc/api_event.dart';
import 'package:flutteroperacionrest/bloc/api_state.dart';
import 'package:flutteroperacionrest/repositorio/api_repository.dart';

class ConsumoPage extends StatelessWidget {
  const ConsumoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApiBloc(ApiRepository())..add(FetchDataEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Consumo de API')),
        body: BlocBuilder<ApiBloc, ApiState>(
          builder: (context, state) {
            if (state is ApiInitialState) {
              return const Center(
                child: Text('Presiona el botón para cargar datos'),
              );
            } else if (state is ApiLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ApiLoadedState) {
              final users = state.data as List<dynamic>;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text('${user['firstName']} ${user['lastName']}'),
                    subtitle: Text(user['email']),
                  );
                },
              );
            } else if (state is ApiErrorState) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
