import 'package:flutter/material.dart';
import 'tip_detail_screen.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color primaryColor = Color(0xFF6FCF97);

  /// ================= DATA TIPS =================
static final List<Map<String, String>> tips = [
  {
    "title": "Istirahat yang Cukup",
    "image": "assets/images/sleep.jpg",
    "category": "Kesehatan Mental",
    "description":
        "• Tidur 7–9 jam setiap malam untuk menjaga keseimbangan emosi\n"
        "• Mengurangi risiko stres, kecemasan, dan kelelahan mental\n"
        "• Membantu meningkatkan fokus, daya ingat, dan konsentrasi belajar\n"
        "• Hindari begadang berlebihan karena dapat memicu burnout pada mahasiswa"
  },
  {
    "title": "Olahraga Secara Rutin",
    "image": "assets/images/exercise.jpg",
    "category": "Kesehatan Fisik & Mental",
    "description":
        "• Lakukan olahraga ringan seperti jogging, jalan pagi, atau stretching\n"
        "• Meningkatkan hormon endorfin yang membantu mengurangi stres\n"
        "• Membantu menjaga kestabilan mood dan mengurangi gejala cemas\n"
        "• Disarankan 3–5 kali dalam seminggu untuk hasil optimal"
  },
  {
    "title": "Manajemen Waktu Belajar",
    "image": "assets/images/study.jpg",
    "category": "Akademik",
    "description":
        "• Gunakan metode Pomodoro (25 menit belajar, 5 menit istirahat)\n"
        "• Buat jadwal harian agar tugas tidak menumpuk\n"
        "• Prioritaskan tugas berdasarkan tingkat kepentingan\n"
        "• Mengurangi tekanan akademik dan mencegah burnout"
  },
  {
    "title": "Meningkatkan Produktivitas",
    "image": "assets/images/productivity.jpg",
    "category": "Pengembangan Diri",
    "description":
        "• Susun to-do list setiap hari untuk mengatur aktivitas\n"
        "• Fokus pada satu tugas dalam satu waktu (hindari multitasking)\n"
        "• Gunakan teknik prioritas seperti Eisenhower Matrix\n"
        "• Membantu meningkatkan rasa kontrol terhadap aktivitas harian"
  },
  {
    "title": "Mengurangi Overthinking",
    "image": "assets/images/overthinking.jpg",
    "category": "Kesehatan Mental",
    "description":
        "• Fokus pada hal yang bisa dikendalikan, bukan yang belum pasti\n"
        "• Latih pikiran untuk berpikir realistis dan positif\n"
        "• Tulis jurnal untuk mengurangi beban pikiran\n"
        "• Jika berlebihan, diskusikan dengan teman atau konselor"
  },
  {
    "title": "Mengelola Stres Akademik",
    "image": "assets/images/stress.jpg",
    "category": "Stress Management",
    "description":
        "• Kenali tanda-tanda stres seperti kelelahan dan sulit fokus\n"
        "• Ambil jeda ketika merasa terlalu terbebani\n"
        "• Gunakan teknik relaksasi seperti pernapasan dalam\n"
        "• Jangan ragu mencari bantuan jika tekanan terlalu berat"
  },
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      /// ================= APP BAR =================
      appBar: AppBar(
        title: const Text(
          "Tips Kesehatan Mental",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black87,
      ),

      /// ================= BODY =================
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// ================= HEADER =================
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF6FCF97),
                  Color(0xFF56CCF2),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.psychology_alt_rounded,
                  color: Colors.white,
                  size: 42,
                ),
                SizedBox(height: 12),
                Text(
                  "Mental Health Companion 🌿",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Jaga kesehatan mentalmu dan tetap produktif selama menjalani perkuliahan.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// ================= TIPS HARI INI =================
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4D6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "🌟 Tips Hari Ini\n\nJangan terlalu keras pada dirimu sendiri. Beristirahat juga merupakan bagian dari produktivitas.",
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// ================= FILTER CHIP =================
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                Chip(
                  backgroundColor: Color(0xFFEAF8F0),
                  label: Text("Semua"),
                ),
                SizedBox(width: 8),
                Chip(
                  backgroundColor: Color(0xFFEAF8F0),
                  label: Text("Stress"),
                ),
                SizedBox(width: 8),
                Chip(
                  backgroundColor: Color(0xFFEAF8F0),
                  label: Text("Motivasi"),
                ),
                SizedBox(width: 8),
                Chip(
                  backgroundColor: Color(0xFFEAF8F0),
                  label: Text("Produktivitas"),
                ),
                SizedBox(width: 8),
                Chip(
                  backgroundColor: Color(0xFFEAF8F0),
                  label: Text("Belajar"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// ================= LIST TIPS =================
          ...tips.map(
            (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TipDetailScreen(
                        title: tip["title"]!,
                        image: tip["image"]!,
                        description: tip["description"]!,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
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
                          tip["image"]!,
                          height: 190,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              tip["title"]!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEAF8F0),
                                borderRadius:
                                    BorderRadius.circular(20),
                              ),
                              child: Text(
                                tip["category"]!,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF2F855A),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              tip["description"]!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black54,
                                height: 1.4,
                              ),
                            ),

                            const SizedBox(height: 12),

                            const Row(
                              children: [
                                Icon(
                                  Icons.touch_app,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Ketuk untuk membaca selengkapnya",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
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
              ),
            ),
          ),

          /// ================= QUOTE =================
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Color(0xFF6FCF97),
                ),
                SizedBox(height: 10),
                Text(
                  "Allah tidak membebani seseorang melainkan sesuai dengan kesanggupannya.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "QS. Al-Baqarah : 286",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// ================= MOTIVASI =================
          Container(
            padding: const EdgeInsets.all(18),
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
                  "\"Kamu tidak harus sempurna hari ini, cukup terus melangkah sedikit demi sedikit.\"",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}