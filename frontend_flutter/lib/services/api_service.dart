import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class ApiService {
  static const String baseUrl = ApiConfig.baseUrl;

  static Future<String> sendMessage(
    String message,
  ) async {
    final response = await http.post(
      Uri.parse(
        "$baseUrl/chat",
      ),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "user_id": ApiConfig.testUserId,
        "message": message,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data["reply"];
    }

    throw Exception(
      "Gagal terhubung ke server",
    );
  }

  static Future<List<dynamic>> getHistory() async {
    final response = await http.get(
      Uri.parse(
        "$baseUrl/history/${ApiConfig.testUserId}",
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(
        response.body,
      );
    }

    return [];
  }
}
