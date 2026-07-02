import 'package:flutter/material.dart';
import 'tip_detail_screen.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  static const Color bg = Color(0xFF0B0B12);
  static const Color surface = Color(0xFF151526);
  static const Color primary = Color(0xFF7C4DFF);

  /// ================= TIPS DATA (UPDATED + EXPERT BASED) =================
  static final List<Map<String, String>> tips = [
    {
      "title": "Tidur Cukup & Berkualitas",
      "category": "Kesehatan Mental",
      "image": "assets/images/sleep.jpg",
      "description":
          "Menurut National Sleep Foundation, mahasiswa membutuhkan 7–9 jam tidur per malam.\n\n"
          "• Tidur cukup membantu stabilkan emosi\n"
          "• Mengurangi risiko stres & kecemasan\n"
          "• Meningkatkan fokus belajar & daya ingat\n\n"
          "Kurang tidur dapat memicu burnout, mood swing, dan penurunan produktivitas akademik."
    },
    {
      "title": "Aktivitas Fisik untuk Kesehatan Mental",
      "category": "Wellbeing",
      "image": "assets/images/exercise.jpg",
      "description":
          "Menurut American Psychological Association (APA), olahraga terbukti mengurangi gejala depresi.\n\n"
          "• Olahraga memicu hormon endorfin (hormon bahagia)\n"
          "• Membantu meredakan tekanan akademik\n"
          "• Cukup 20–30 menit per hari\n\n"
          "Tidak harus berat—jalan kaki saja sudah berdampak positif."
    },
    {
      "title": "Manajemen Waktu Anti Burnout",
      "category": "Produktivitas",
      "image": "assets/images/study.jpg",
      "description":
          "Penelitian Harvard University menyebutkan bahwa manajemen waktu yang buruk meningkatkan stres akademik.\n\n"
          "• Gunakan metode Pomodoro (25–5)\n"
          "• Pecah tugas besar menjadi kecil\n"
          "• Hindari belajar sistem kebut semalam\n\n"
          "Manajemen waktu yang baik = pikiran lebih tenang."
    },
    {
      "title": "Mengatasi Overthinking",
      "category": "Mental Health",
      "image": "assets/images/overthinking.jpg",
      "description":
          "Menurut psikolog klinis, overthinking terjadi karena fokus pada hal yang belum tentu terjadi.\n\n"
          "• Tanyakan: apakah ini fakta atau asumsi?\n"
          "• Tulis jurnal untuk meredakan pikiran\n"
          "• Alihkan fokus ke hal yang bisa dikontrol\n\n"
          "Latihan mindfulness sangat membantu menenangkan pikiran."
    },
    {
      "title": "Mengelola Stres Akademik",
      "category": "Stress Management",
      "image": "assets/images/stress.jpg",
      "description":
          "WHO menyatakan stres akademik adalah kondisi umum pada mahasiswa.\n\n"
          "• Kenali tanda stres sejak awal\n"
          "• Ambil jeda saat merasa overload\n"
          "• Gunakan teknik pernapasan 4-7-8\n\n"
          "Jika berlanjut, konsultasi dengan konselor sangat disarankan."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,

      /// ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Tips Kesehatan Mental",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// ================= HEADER =================
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.white10),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.psychology_alt, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text(
                  "Mental Health Companion",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Tips ini dibuat berdasarkan penelitian psikologi & kesehatan mental modern untuk mahasiswa.",
                  style: TextStyle(color: Colors.white60),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// ================= DAILY QUOTE =================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white10),
            ),
            child: const Text(
              "💡 Ingat: istirahat bukan tanda malas, tapi bagian dari proses berkembang.",
              style: TextStyle(color: Colors.white70),
            ),
          ),

          const SizedBox(height: 16),

          /// ================= TIPS LIST =================
          ...tips.map(
            (tip) => GestureDetector(
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
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        tip["title"]!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        tip["description"]!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white60,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: const [
                          Icon(Icons.touch_app,
                              size: 14, color: Colors.white38),
                          SizedBox(width: 6),
                          Text(
                            "Baca selengkapnya",
                            style: TextStyle(
                              color: Colors.white38,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// ================= MOTIVATION =================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: primary.withOpacity(0.3)),
            ),
            child: const Text(
              "🌿 Kamu tidak harus sempurna. Cukup menjadi lebih baik dari kemarin.",
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