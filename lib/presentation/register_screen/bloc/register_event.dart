part of 'register_bloc.dart';

/// Abstract class for all events that can be dispatched from the
/// Register widget.
///
/// Events must be immutable and implement the [Equatable] interface.
abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the Register widget is first created.
class RegisterInitialEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the user submits the registration form.
class RegisterSubmitEvent extends RegisterEvent {
  final String email;
  final String password;
  final String phone;

  RegisterSubmitEvent(this.email, this.password, this.phone);

  @override
  List<Object?> get props => [email, password, phone];
}
