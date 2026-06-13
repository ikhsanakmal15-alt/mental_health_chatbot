import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/chat_history.dart';

class HistoryService {
  static const String baseUrl =
      "http://10.0.2.2:8000";

  static Future<List<ChatHistory>>
      getHistories() async {

    final response = await http.get(
      Uri.parse(
        "$baseUrl/history/1", // <-- tambahkan user_id
      ),
    );

    if (response.statusCode == 200) {

      List data = jsonDecode(response.body);

      return data
          .map(
            (e) => ChatHistory.fromJson(e),
          )
          .toList();
    }

    return [];
  }
}