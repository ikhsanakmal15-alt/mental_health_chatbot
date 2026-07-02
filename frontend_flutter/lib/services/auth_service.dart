import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "http://10.0.2.2:8000";

  /// ================= LOGIN =================
  static Future<Map<String, dynamic>?> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      final data = jsonDecode(response.body);

      /// backend success
      if (response.statusCode == 200) {
        return data; // {access_token, token_type, user}
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// ================= REGISTER =================
  static Future<bool> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "fullname": name,
          "email": email,
          "password": password,
        }),
      );

      /// backend kamu return 200 atau 400
      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}