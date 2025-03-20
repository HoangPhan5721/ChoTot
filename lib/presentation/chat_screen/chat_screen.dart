import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './blocs/chat_bloc.dart';
import './blocs/chat_event.dart';
import './blocs/chat_state.dart';
import './models/message_model.dart';
import './widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final String token;
  final String sellerId;
  final String sellerName;
  final String? profileImage;

  const ChatScreen({
    Key? key,
    required this.token,
    required this.sellerId,
    required this.sellerName,
    this.profileImage,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(
      LoadMessages(
        token: widget.token,
        senderId: "1", // Replace with dynamic user ID
        receiverId: widget.sellerId,
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      final message = Message(
        id: DateTime.now().millisecondsSinceEpoch,
        senderId: 1, // Replace with dynamic user ID
        receiverId: int.parse(widget.sellerId),
        postId: 0,
        content: _messageController.text,
        status: "sent",
        createdAt: DateTime.now(),
      );
      context.read<ChatBloc>().add(SendMessage(message: message));
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            if (widget.profileImage != null)
              CircleAvatar(
                backgroundImage: NetworkImage(widget.profileImage!),
                onBackgroundImageError: (exception, stackTrace) {
                  print("Image load error: $exception");
                },
                child: Icon(Icons.person), // Fallback
              ),
            const SizedBox(width: 10),
            Text(widget.sellerName),
          ],
        ),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ChatLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      return MessageBubble(
                        message: state.messages[index],
                        isMe: state.messages[index].senderId == 1,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _messageController,
                    onSubmitted: (_) => _sendMessage(),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _sendMessage,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("Error loading messages"));
          }
        },
      ),
    );
  }
}
