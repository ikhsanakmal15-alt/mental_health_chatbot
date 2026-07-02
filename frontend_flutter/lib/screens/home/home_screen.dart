import 'package:flutter/material.dart';

import '../chat/chat_screen.dart';
import '../tips/tips_screen.dart';
import '../history/history_screen.dart';
import '../counselor/counselor_screen.dart';
import '../article/article_screen.dart';

class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF120A25),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2A1450), // soft purple top
              Color(0xFF120A25), // deep purple bottom (NOT black)
            ],
          ),
        ),

        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [

              /// ================= HEADER =================
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF8B5CFF),
                      Color(0xFFB388FF),
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Color(0xFF7C4DFF)),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Selamat datang, ${userName.isEmpty ? 'Mahasiswa' : userName}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Pelan-pelan saja, kamu tidak sendiri 🌿",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// ================= HERO IMAGE =================
              Container(
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/mountain.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.65),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Jaga Kesehatan Mental",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Mulai dari diri sendiri",
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Kamu berharga, jangan lupa istirahat.",
                        style: TextStyle(color: Colors.white60),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// ================= MOOD =================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF22133D),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white10),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mood Hari Ini",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("😔", style: TextStyle(fontSize: 26)),
                        Text("😕", style: TextStyle(fontSize: 26)),
                        Text("😐", style: TextStyle(fontSize: 26)),
                        Text("🙂", style: TextStyle(fontSize: 26)),
                        Text("😍", style: TextStyle(fontSize: 26)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                "Fitur Utama",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              /// ================= FEATURES =================
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.15,
                ),
                children: [
                  _card(context, "Chat AI", Icons.chat_bubble,
                      const Color(0xFF8B5CFF), const ChatScreen()),

                  _card(context, "Tips Mental", Icons.lightbulb,
                      const Color(0xFFFFC107), const TipsScreen()),

                  _card(context, "Riwayat", Icons.history,
                      const Color(0xFF4FC3F7), const HistoryScreen()),

                  _card(context, "Konselor", Icons.people,
                      const Color(0xFF81C784), const CounselorScreen()),
                ],
              ),

              const SizedBox(height: 20),

              /// ================= ARTICLE =================
              const Text(
                "Artikel Pilihan",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _article(context, "assets/images/anxiety.jpg",
                  "Mengelola Anxiety Saat Kuliah",
                  "Tips menjaga fokus & ketenangan pikiran"),

              _article(context, "assets/images/overthinking.jpg",
                  "Mengurangi Overthinking",
                  "Latihan sederhana untuk pikiran tenang"),

              _article(context, "assets/images/burnout.jpg",
                  "Menghindari Burnout",
                  "Jaga energi agar tetap stabil setiap hari"),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= FEATURE CARD =================
  Widget _card(BuildContext context, String title, IconData icon,
      Color color, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1436),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color),
              ),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= ARTICLE CARD (CLICKABLE + IMAGE) =================
  Widget _article(BuildContext context, String image, String title,
      String subtitle) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ArticleScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1436),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Icon(Icons.arrow_forward_ios,
                size: 14, color: Colors.white38),

            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}