class ChatHistory {
  final int id;
  final String userMessage;
  final String botResponse;
  final String createdAt;

  ChatHistory({
    required this.id,
    required this.userMessage,
    required this.botResponse,
    required this.createdAt,
  });

  factory ChatHistory.fromJson(
      Map<String, dynamic> json) {
    final List messages =
        json["messages"] ?? [];

    String userMessage = "";
    String botResponse = "";

    for (final msg in messages) {
      if (msg["sender"] == "user") {
        userMessage = msg["message"] ?? "";
      } else if (msg["sender"] == "bot") {
        botResponse = msg["message"] ?? "";
      }
    }

    return ChatHistory(
      id: json["chat_id"] ?? 0,
      userMessage: userMessage,
      botResponse: botResponse,
      createdAt: json["created_at"] ?? "",
    );
  }
}