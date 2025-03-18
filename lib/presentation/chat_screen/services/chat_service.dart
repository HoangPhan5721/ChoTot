import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/conversation_model.dart';
import '../models/message_model.dart';

class ChatService {
  final String baseUrl = "https://nodejs-cgor.onrender.com/api/chat";

  Future<List<Conversation>> getConversations(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/conversations/"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data["conversations"] as List)
          .map((json) => Conversation.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load conversations");
    }
  }

  Future<List<Message>> getMessages(String token, String senderId, String receiverId) async {
    final response = await http.get(
      Uri.parse("$baseUrl/$senderId/$receiverId"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data["messages"] as List)
          .map((json) => Message.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load messages");
    }
  }
}
