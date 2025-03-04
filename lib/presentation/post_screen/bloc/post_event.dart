part of 'post_bloc.dart';
/// Abstract class for all events that can be dispatched from the
///Post widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
/// Event that is dispatched when the Post widget is first created.
class PostInitialEvent extends PostEvent {
  @override
  List<Object?> get props => [];
}