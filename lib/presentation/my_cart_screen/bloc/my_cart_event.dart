part of 'my_cart_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///MyCart widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class MyCartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the MyCart widget is first created.
class MyCartInitialEvent extends MyCartEvent {
  @override
  List<Object?> get props => [];
}
