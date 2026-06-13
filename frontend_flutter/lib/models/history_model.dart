class HistoryModel {

  final int chatId;

  final String createdAt;

  final List<dynamic> messages;

  HistoryModel({

    required this.chatId,

    required this.createdAt,

    required this.messages,

  });

  factory HistoryModel.fromJson(
      Map<String, dynamic> json) {

    return HistoryModel(

      chatId:
          json["chat_id"],

      createdAt:
          json["created_at"],

      messages:
          json["messages"],

    );
  }
}