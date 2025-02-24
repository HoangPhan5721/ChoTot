import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/login_model.dart';

part 'login_event.dart';

part 'login_state.dart';

/// A bloc that manages the state of a Login according to the event that is dispatched to it.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState) {
    on<LoginInitialEvent>(_onInitialize);
    on<ChangeCheckBoxEvent>(_changeCheckBox);
  }

  _onInitialize(
    LoginInitialEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copywith(
        fullNameController: TextEditingController(),
        passwordController: TextEditingController(),
        remembermeone: false,
      ),
    );
  }

  _changeCheckBox(
    ChangeCheckBoxEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copywith(
      remembermeone: event.value,
    ));
  }
}
