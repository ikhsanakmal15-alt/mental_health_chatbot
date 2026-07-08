import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/api_config.dart';


class AuthService {

  static const String baseUrl = ApiConfig.baseUrl;


  // ================= LOGIN =================

  static Future<Map<String, dynamic>?> login(
    String email,
    String password,
  ) async {

    try {

      final response = await http.post(

        Uri.parse(
          "$baseUrl/auth/login"
        ),

        headers: {
          "Content-Type": "application/json",
        },

        body: jsonEncode({

          "email": email,

          "password": password,

        }),

      ).timeout(
        const Duration(seconds: 10),
      );


      print("LOGIN STATUS : ${response.statusCode}");
      print("LOGIN BODY : ${response.body}");


      final data = jsonDecode(
        response.body
      );


      if(response.statusCode == 200){


        // simpan user id untuk chat/history
        if(data["user"] != null){

          final prefs =
              await SharedPreferences.getInstance();


          await prefs.setInt(
            "user_id",
            data["user"]["id"],
          );

        }


        return data;

      }


      return null;


    }catch(e){

      print(
        "LOGIN ERROR : $e"
      );

      return null;

    }

  }




  // ================= REGISTER =================


  static Future<bool> register(
    String name,
    String email,
    String password,
  ) async {


    try {


      final response = await http.post(

        Uri.parse(
          "$baseUrl/auth/register"
        ),

        headers: {

          "Content-Type":"application/json",

        },


        body:jsonEncode({

          "fullname":name,

          "email":email,

          "password":password,

        }),


      ).timeout(

        const Duration(seconds:10),

      );



      print(
        "REGISTER STATUS : ${response.statusCode}"
      );

      print(
        "REGISTER BODY : ${response.body}"
      );



      if(response.statusCode == 200){

        return true;

      }


      return false;



    }catch(e){


      print(
        "REGISTER ERROR : $e"
      );


      return false;


    }

  }



  // ================= LOGOUT =================


  static Future<void> logout() async {

    final prefs =
        await SharedPreferences.getInstance();


    await prefs.remove(
      "user_id"
    );

  }

}