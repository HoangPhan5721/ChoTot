class Message {
  final int id;
  final int senderId;
  final int receiverId;
  final int postId;
  final String content;
  final String status;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.postId,
    required this.content,
    required this.status,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json["id"],
      senderId: json["sender_id"],
      receiverId: json["receiver_id"],
      postId: json["post_id"],
      content: json["content"],
      status: json["status"],
      createdAt: DateTime.parse(json["created_at"]),
    );
  }
}
