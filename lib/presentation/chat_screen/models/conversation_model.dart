class Conversation {
  final int id;
  final String name;
  final String lastMessage;
  final DateTime createdAt;
  final int lastSenderId;

  Conversation({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.createdAt,
    required this.lastSenderId,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json["id"],
      name: json["name"],
      lastMessage: json["last_message"],
      createdAt: DateTime.parse(json["created_at"]),
      lastSenderId: json["last_sender_id"],
    );
  }
}
