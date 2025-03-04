import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/post_model.dart';

part 'post_event.dart';

part 'post_state.dart';

/// A bloc that manages the state of a Post according to the event that is dispatched to it.
class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(PostState initialState) : super(initialState) {
    on<PostInitialEvent>(_onInitialize);
  }

  _onInitialize(
    PostInitialEvent event,
    Emitter<PostState> emit,
  ) async {
    emit(
      state.copyWith(
        inputfieldoneController: TextEditingController(),
        categoryInputSectionController: TextEditingController(),
        inputfieldfiveController: TextEditingController(),
        pricetwoController: TextEditingController(),
        locationtwoController: TextEditingController(),
      ),
    );
  }
}
