import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ArticleDetailScreen extends StatelessWidget {
  final String title;
  final String image;
  final String description;

  const ArticleDetailScreen({
    super.key,
    required this.title,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.7,
            ),
          ),

          const SizedBox(height: 24),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF8F0),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              "💡 Tips:\n\nLuangkan waktu setiap hari untuk menjaga kesehatan mental, beristirahat dengan cukup, dan jangan ragu mencari bantuan profesional jika diperlukan.",
              style: TextStyle(
                fontSize: 15,
                height: 1.6,
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}