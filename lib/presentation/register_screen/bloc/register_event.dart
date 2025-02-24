part of 'register_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///Login widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the Login widget is first created.
class RegisterInitialEvent extends RegisterEvent
{
  @override
  List<Object?> get props => [];
}