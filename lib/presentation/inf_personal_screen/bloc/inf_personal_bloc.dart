import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc
import 'package:http/http.dart' as http;
import 'package:intern/presentation/inf_personal_screen/model/inf_personal_model.dart';
import 'inf_personal_event.dart';
import 'inf_personal_state.dart';

class InfPersonalBloc extends Bloc<InfPersonalEvent, InfPersonalState> {
  InfPersonalBloc() : super(InfPersonalState(infPersonalModelObj: InfPersonalModel())) {
    on<InfPersonalInitialEvent>(_onInitial); // Register event handler
  }

  Future<void> _onInitial(
      InfPersonalInitialEvent event,
      Emitter<InfPersonalState> emit,
      ) async {
    emit(state.copyWith(isLoading: true)); // Use the current state
    try {
      final response = await http.get(
        Uri.parse('https://nodejs-cgor.onrender.com/api/users/get/nguyen29082003@gmail.com'),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final model = InfPersonalModel.fromJson(data);
        emit(state.copyWith(infPersonalModelObj: model, isLoading: false));
      } else {
        emit(state.copyWith(error: 'Failed to load data', isLoading: false));
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
