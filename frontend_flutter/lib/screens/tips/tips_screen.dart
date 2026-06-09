import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  static const backgroundColor = Color(0xFFF8FAFC);
  static const primaryColor = Color(0xFF6FCF97);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      /// ================= APP BAR =================
      appBar: AppBar(
        title: const Text(
          "Tips Kesehatan Mental",
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

          /// ================= HEADER CARD =================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF8F0),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Color(0xFF6FCF97),
                  size: 40,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Tips ini membantu kamu menjaga keseimbangan emosi & produktivitas 🌿",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// ================= TIPS LIST =================
          _TipCard(
            title: "Kelola waktu belajar",
            subtitle: "Gunakan teknik pomodoro agar lebih fokus",
            icon: Icons.schedule,
          ),

          const SizedBox(height: 12),

          _TipCard(
            title: "Tidur cukup",
            subtitle: "Tidur 7–8 jam untuk menjaga stabilitas emosi",
            icon: Icons.nightlight_round,
          ),

          const SizedBox(height: 12),

          _TipCard(
            title: "Olahraga rutin",
            subtitle: "Aktivitas fisik membantu mengurangi stres",
            icon: Icons.fitness_center,
          ),

          const SizedBox(height: 12),

          _TipCard(
            title: "Kurangi overthinking",
            subtitle: "Fokus pada hal yang bisa kamu kontrol",
            icon: Icons.psychology_outlined,
          ),
        ],
      ),
    );
  }
}

/// ================= REUSABLE CARD =================
class _TipCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _TipCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFEAF8F0),
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
        ],
      ),
    );
  }
}