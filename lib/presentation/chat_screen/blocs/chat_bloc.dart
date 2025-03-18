import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/chat_service.dart';
import 'chat_event.dart';
import 'chat_state.dart';
import '../models/message_model.dart';


class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService chatService;

  ChatBloc({required this.chatService}) : super(ChatInitial()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessage>(_onSendMessage);
  }

  void _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      final messages = await chatService.getMessages(event.token, event.senderId, event.receiverId);
      emit(ChatLoaded(messages: messages));
    } catch (e) {
      emit(ChatError(error: e.toString()));
    }
  }

  void _onSendMessage(SendMessage event, Emitter<ChatState> emit) {
    if (state is ChatLoaded) {
      final currentMessages = (state as ChatLoaded).messages;
      final updatedMessages = List<Message>.from(currentMessages)..add(event.message);
      emit(ChatLoaded(messages: updatedMessages));
    }
  }
}
