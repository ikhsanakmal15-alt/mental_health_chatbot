import 'package:flutter/material.dart';

// ⬇️ IMPORT HALAMAN KAMU
import '../chat/chat_screen.dart';
import '../tips/tips_screen.dart';
import '../history/history_screen.dart';
import '../counselor/counselor_screen.dart';

// ⬇️ IMPORT WIDGET REUSABLE
import '../../widgets/home_menu_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const primaryColor = Color(0xFF6FCF97);
  static const softMint = Color(0xFFEAF8F0);
  static const backgroundColor = Color(0xFFF8FAFC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            /// ================= HEADER =================
            const Text(
              "Halo Ikhsan 👋",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Bagaimana perasaanmu hari ini? 🌿",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            /// ================= MENU GRID =================
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              children: [
                HomeMenuCard(
                  title: "Chat AI",
                  subtitle: "Curhat & Konsultasi",
                  icon: Icons.chat_bubble_outline,
                  color: softMint,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ChatScreen(),
                      ),
                    );
                  },
                ),

                HomeMenuCard(
                  title: "Tips Mental",
                  subtitle: "Edukasi & Kesehatan",
                  icon: Icons.lightbulb_outline,
                  color: const Color(0xFFFFF5DD),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TipsScreen(),
                      ),
                    );
                  },
                ),

                HomeMenuCard(
                  title: "Riwayat",
                  subtitle: "Percakapan kamu",
                  icon: Icons.history,
                  color: const Color(0xFFEAF7FF),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HistoryScreen(),
                      ),
                    );
                  },
                ),

                HomeMenuCard(
                  title: "Konselor",
                  subtitle: "Bantuan profesional",
                  icon: Icons.people_outline,
                  color: const Color(0xFFF8EEFF),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CounselorScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 25),

            /// ================= ARTICLE SECTION =================
            const Text(
              "Artikel Pilihan",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            /// ARTICLE CARD 1
            _ArticleCard(
              title: "5 Cara Mengelola Stres Saat Kuliah",
              subtitle:
                  "Tekanan akademik bisa diatasi dengan teknik sederhana yang efektif",
            ),

            const SizedBox(height: 12),

            /// ARTICLE CARD 2
            _ArticleCard(
              title: "Menjaga Keseimbangan Emosi",
              subtitle:
                  "Belajar mengenali dan mengatur emosi dalam kehidupan sehari-hari",
            ),

            const SizedBox(height: 12),

            /// ARTICLE CARD 3
            _ArticleCard(
              title: "Cara Mengurangi Overthinking",
              subtitle:
                  "Latihan sederhana untuk menenangkan pikiran yang berlebihan",
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= ARTICLE CARD =================
class _ArticleCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _ArticleCard({
    required this.title,
    required this.subtitle,
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
          const Icon(
            Icons.menu_book_rounded,
            size: 40,
            color: Color(0xFF6FCF97),
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
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  "Baca selengkapnya →",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6FCF97),
                    fontWeight: FontWeight.w600,
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