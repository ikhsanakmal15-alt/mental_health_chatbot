import 'package:flutter/material.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  static const primaryColor = Color(0xFF6FCF97);
  static const backgroundColor = Color(0xFFF8FAFC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      /// ================= APP BAR =================
      appBar: AppBar(
        title: const Text(
          "Artikel Kesehatan Mental",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),

      /// ================= BODY =================
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 10),

          /// ARTICLE CARD 1
          _ArticleCard(
            title: "Mengatasi Stres Akademik",
            subtitle: "Cara sederhana mengelola tekanan kuliah",
            icon: Icons.psychology_alt_outlined,
            color: const Color(0xFFEAF8F0),
          ),

          const SizedBox(height: 12),

          /// ARTICLE CARD 2
          _ArticleCard(
            title: "Menjaga Kesehatan Mental",
            subtitle: "Tips menjaga keseimbangan emosi harian",
            icon: Icons.favorite_outline,
            color: const Color(0xFFFFF5DD),
          ),

          const SizedBox(height: 12),

          /// ARTICLE CARD 3 (tambahan biar lebih hidup)
          _ArticleCard(
            title: "Mengatasi Overthinking",
            subtitle: "Strategi untuk menenangkan pikiran",
            icon: Icons.self_improvement,
            color: const Color(0xFFF2F0FF),
          ),
        ],
      ),
    );
  }
}

/// ================= REUSABLE CARD =================
class _ArticleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _ArticleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              icon,
              color: const Color(0xFF6FCF97),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}