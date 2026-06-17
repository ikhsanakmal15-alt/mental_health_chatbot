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
          "Kecemasan saat menghadapi tugas, ujian, atau tuntutan akademik adalah hal yang umum dialami mahasiswa. Pelajari cara mengenali dan mengelola anxiety dengan sehat."
    },
    {
      "title": "Mengenali dan Mencegah Burnout",
      "image": "assets/images/burnout.jpg",
      "category": "Burnout",
      "description":
          "Terlalu banyak tekanan akademik dan kurang waktu istirahat dapat menyebabkan burnout. Kenali tanda-tandanya dan pelajari cara menjaga keseimbangan aktivitas sehari-hari."
    },
    {
      "title": "Cara Mengurangi Overthinking",
      "image": "assets/images/overthinking.jpg",
      "category": "Stress",
      "description":
          "Pikiran berlebihan dapat menguras energi mental. Temukan teknik sederhana untuk menenangkan diri."
    },
    {
      "title": "Produktif Tanpa Burnout",
      "image": "assets/images/productivity.jpg",
      "category": "Produktivitas",
      "description":
          "Produktivitas bukan tentang bekerja terus menerus, tetapi bekerja secara cerdas dan seimbang."
    },
    {
      "title": "Belajar Lebih Fokus",
      "image": "assets/images/study.jpg",
      "category": "Belajar",
      "description":
          "Gunakan teknik belajar yang efektif agar lebih fokus dan tidak mudah merasa lelah secara mental."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text(
          "Artikel Kesehatan Mental",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [
          /// ================= HEADER =================
          Container(
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),

            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.menu_book_rounded,
                  color: Colors.white,
                  size: 45,
                ),

                SizedBox(height: 10),

                Text(
                  "Edukasi Kesehatan Mental 📚",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "Pelajari cara menjaga kesehatan mental, mengelola stres, dan meningkatkan produktivitas selama kuliah.",
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// ================= KATEGORI =================
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                _CategoryChip(
                  icon: Icons.psychology,
                  label: "Mental Health",
                ),
                _CategoryChip(
                  icon: Icons.self_improvement,
                  label: "Stress",
                ),
                _CategoryChip(
                  icon: Icons.favorite,
                  label: "Motivasi",
                ),
                _CategoryChip(
                  icon: Icons.school,
                  label: "Akademik",
                ),
                _CategoryChip(
                  icon: Icons.trending_up,
                  label: "Produktivitas",
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// ================= ARTIKEL =================
          ...articles.map(
            (article) => _ArticleCard(
              title: article["title"]!,
              image: article["image"]!,
              description: article["description"]!,
            ),
          ),

          const SizedBox(height: 20),

          /// ================= MOTIVASI =================
          Container(
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: const Color(0xFFEAF8F0),
              borderRadius: BorderRadius.circular(20),
            ),

            child: const Column(
              children: [
                Text(
                  "💡 Motivasi Hari Ini",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  "\"Kesehatan mental yang baik bukan berarti selalu bahagia, tetapi mampu menghadapi tantangan hidup dengan lebih sehat.\"",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

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
    return InkWell(
      borderRadius: BorderRadius.circular(20),

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
        margin: const EdgeInsets.only(bottom: 16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.8),
              blurRadius: 10,
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
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: AppColors.primary,
                      ),

                      const SizedBox(width: 5),

                      Text(
                        "Baca selengkapnya",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
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

class _CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _CategoryChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),

      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.primary,
          ),

          const SizedBox(width: 6),

          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}