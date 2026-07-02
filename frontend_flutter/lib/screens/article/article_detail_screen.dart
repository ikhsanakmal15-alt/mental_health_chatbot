import 'dart:ui';
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

      /// ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// ================= IMAGE HERO =================
          ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              children: [

                Image.asset(
                  image,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                /// gradient overlay biar elegan
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          /// ================= TITLE =================
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 12),

          /// ================= DESCRIPTION CARD =================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10),
            ),
            child: Text(
              description,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 15,
                height: 1.7,
                color: Colors.white70,
              ),
            ),
          ),

          const SizedBox(height: 18),

          /// ================= INFO BADGE =================
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.3),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.menu_book,
                  size: 18,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  "Artikel Edukasi Mental Health",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          /// ================= TIPS BOX =================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white10),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "💡 Tips Penting",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "• Luangkan waktu istirahat setiap hari\n"
                  "• Jangan memendam stres sendirian\n"
                  "• Ceritakan ke teman atau konselor\n"
                  "• Batasi overthinking dengan aktivitas positif\n\n"
                  "Kesehatan mental adalah investasi jangka panjang.",
                  style: TextStyle(
                    color: Colors.white60,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// ================= FOOT NOTE =================
          const Text(
            "Sumber: WHO • APA (American Psychological Association) • Literatur Psikologi Klinis",
            style: TextStyle(
              color: Colors.white38,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}