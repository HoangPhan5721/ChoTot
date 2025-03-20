import '../models/message_model.dart';

abstract class ChatEvent {}

class LoadMessages extends ChatEvent {
  final String token;
  final String senderId;
  final String receiverId;

  LoadMessages({required this.token, required this.senderId, required this.receiverId});
}

class SendMessage extends ChatEvent {
  final Message message;

  SendMessage({required this.message});
}
