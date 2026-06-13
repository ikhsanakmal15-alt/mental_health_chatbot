import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl =
      "http://10.0.2.2:8000";

  static Future<String> sendMessage(
    String message,
  ) async {

    final response = await http.post(

      Uri.parse(
        "$baseUrl/chat",
      ),

      headers: {
        "Content-Type":
            "application/json"
      },

      body: jsonEncode({

        "user_id": 1,

        "message": message

      }),

    );

    if (response.statusCode == 200) {

      final data =
          jsonDecode(response.body);

      return data["reply"];

    }

    throw Exception(
      "Gagal terhubung ke server"
    );
  }
  static Future<List<dynamic>>
getHistory() async {

  final response = await http.get(

    Uri.parse(
      "$baseUrl/history/1",
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
