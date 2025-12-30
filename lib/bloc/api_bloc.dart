import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroperacionrest/bloc/api_event.dart';
import 'package:flutteroperacionrest/bloc/api_state.dart';
import 'package:flutteroperacionrest/repositorio/api_repository.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final ApiRepository apiRepository;

  ApiBloc(this.apiRepository) : super(ApiInitialState()) {
    on<FetchDataEvent>((event, emit) async {
      emit(ApiLoadingState());
      try {
        final data = await apiRepository.fetchData();
        emit(ApiLoadedState(data));
      } catch (e, stackTrace) {
        print("Error detallado: $e");
        print("TRACE: ${stackTrace}");
        emit(ApiErrorState(e.toString()));
      }
    });
  }
}