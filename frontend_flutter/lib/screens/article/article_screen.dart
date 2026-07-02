import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'article_detail_screen.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  static final List<Map<String, String>> articles = [
    {
      "title": "Mengelola Anxiety Saat Kuliah",
      "image": "assets/images/anxiety.jpg",
      "category": "Anxiety",
      "description":
          "Kecemasan saat kuliah adalah hal umum. Artikel ini membahas cara mengenali tanda anxiety dan mengelolanya dengan teknik psikologi modern."
    },
    {
      "title": "Mengenali Burnout Mahasiswa",
      "image": "assets/images/burnout.jpg",
      "category": "Burnout",
      "description":
          "Burnout terjadi karena tekanan akademik berlebihan. Pelajari cara mencegah kelelahan mental secara ilmiah."
    },
    {
      "title": "Mengurangi Overthinking",
      "image": "assets/images/overthinking.jpg",
      "category": "Mindset",
      "description":
          "Overthinking bisa mengganggu fokus. Artikel ini membantu kamu memahami cara mengelola pikiran berlebih."
    },
    {
      "title": "Produktif Tanpa Stres",
      "image": "assets/images/productivity.jpg",
      "category": "Produktivitas",
      "description":
          "Produktivitas bukan tentang bekerja lebih keras, tapi lebih cerdas dan seimbang."
    },
  ];

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
        title: const Text(
          "Artikel Kesehatan Mental",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// ================= HEADER GLASS =================
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.surface.withOpacity(0.9),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.white10),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.menu_book_rounded,
                    color: Colors.white, size: 40),

                SizedBox(height: 10),

                Text(
                  "Edukasi Mental Health 📚",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  "Artikel ini disusun berdasarkan literatur psikologi modern, WHO, dan American Psychological Association (APA).",
                  style: TextStyle(color: Colors.white60),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// ================= CATEGORY CHIPS =================
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                _CategoryChip(label: "Anxiety"),
                _CategoryChip(label: "Burnout"),
                _CategoryChip(label: "Mindset"),
                _CategoryChip(label: "Produktivitas"),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// ================= ARTICLE LIST =================
          ...articles.map(
            (article) => _ArticleCard(
              title: article["title"]!,
              image: article["image"]!,
              description: article["description"]!,
            ),
          ),

          const SizedBox(height: 20),

          /// ================= MOTIVATION =================
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10),
            ),
            child: const Text(
              "💡 Kesehatan mental bukan tentang selalu bahagia, tetapi tentang kemampuan mengelola emosi dengan sehat.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

/// ================= ARTICLE CARD =================
class _ArticleCard extends StatelessWidget {
  final String title;
  final String image;
  final String description;

  const _ArticleCard({
    required this.title,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticleDetailScreen(
              title: title,
              image: image,
              description: description,
            ),
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 14),

        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.asset(
                image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white60,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Baca selengkapnya →",
                    style: TextStyle(
                      color: Color(0xFFB388FF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= CATEGORY CHIP =================
class _CategoryChip extends StatelessWidget {
  final String label;

  const _CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}