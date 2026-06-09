import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  static const backgroundColor = Color(0xFFF8FAFC);
  static const primaryColor = Color(0xFF6FCF97);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      /// ================= APP BAR =================
      appBar: AppBar(
        title: const Text(
          "Riwayat Percakapan",
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

          /// ================= EMPTY STATE =================
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF8F0),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: const [
                Icon(
                  Icons.history,
                  size: 50,
                  color: Color(0xFF6FCF97),
                ),
                SizedBox(height: 12),
                Text(
                  "Belum ada riwayat percakapan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Mulai chat dengan AI untuk menyimpan riwayat percakapan kamu 🌿",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// ================= SAMPLE HISTORY CARD =================
          _HistoryCard(
            title: "Percakapan Stres Akademik",
            subtitle: "Kemarin • 14:30",
            icon: Icons.chat_bubble_outline,
          ),

          const SizedBox(height: 12),

          _HistoryCard(
            title: "Overthinking saat ujian",
            subtitle: "2 hari lalu • 20:10",
            icon: Icons.psychology_outlined,
          ),
        ],
      ),
    );
  }
}

/// ================= REUSABLE CARD =================
class _HistoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _HistoryCard({
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