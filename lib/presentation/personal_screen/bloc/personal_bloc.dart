import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/personal_model.dart';

part 'personal_event.dart';

part 'personal_state.dart';

/// A bloc that manages the state of a Personal according to the event that
class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  PersonalBloc(PersonalState initialState) : super(initialState) {
    on<PersonalInitialEvent>(_onInitialize);
  }

  _onInitialize(
    PersonalInitialEvent event,
    Emitter<PersonalState> emit,
  ) async {}
}
