import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/chat_history.dart';

class HistoryService {
  static const String baseUrl = ApiConfig.baseUrl;

  static Future<List<ChatHistory>> getHistories() async {
    final response = await http.get(
      Uri.parse(
        "$baseUrl/history/${ApiConfig.testUserId}",
      ),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data
          .map(
            (e) => ChatHistory.fromJson(e),
          )
          .toList();
    }

    return [];
  }
}