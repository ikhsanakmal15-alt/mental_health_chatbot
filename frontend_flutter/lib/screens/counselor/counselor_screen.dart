import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CounselorScreen extends StatelessWidget {
  const CounselorScreen({super.key});

  static const Color primaryColor = Color(0xFF6FCF97);
  static const Color backgroundColor = Color(0xFFF8FAFC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      /// ================= APP BAR =================
      appBar: AppBar(
        title: const Text(
          "Bantuan Konselor",
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
                  Icons.support_agent,
                  color: Colors.white,
                  size: 42,
                ),
                SizedBox(height: 12),
                Text(
                  "Butuh Teman Bicara? 🌿",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Konselor siap membantu kamu menghadapi tekanan akademik, stres, kecemasan, dan masalah emosional lainnya.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
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
              color: const Color(0xFFFFF4D6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "💛 Tidak apa-apa meminta bantuan. Berbicara dengan seseorang adalah langkah berani menuju kesehatan mental yang lebih baik.",
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// ================= KONSELOR 1 =================
          const _CounselorCard(
            name: "Konselor Kampus",
            phone: "6285175141016",
            specialization: "Kesehatan Mental Mahasiswa",
            icon: Icons.person_outline,
          ),

          /// ================= KONSELOR 2 =================
          const _CounselorCard(
            name: "Psikolog Universitas",
            phone: "6289691426114",
            specialization: "Konseling Akademik & Emosi",
            icon: Icons.psychology_alt_outlined,
          ),

          const SizedBox(height: 20),

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
                  color: primaryColor,
                ),
                SizedBox(height: 10),
                Text(
                  "Allah tidak membebani seseorang melainkan sesuai dengan kesanggupannya.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5),
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

          /// ================= EMERGENCY =================
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.emergency,
                  color: Colors.red,
                  size: 35,
                ),
                SizedBox(height: 10),
                Text(
                  "Butuh Bantuan Mendesak?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Jika kamu merasa dalam kondisi darurat emosional atau membutuhkan bantuan segera, segera hubungi keluarga, dosen wali, pihak kampus, atau layanan kesehatan terdekat.",
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

/// ================= CARD KONSELOR =================
class _CounselorCard extends StatelessWidget {
  final String name;
  final String phone;
  final String specialization;
  final IconData icon;

  const _CounselorCard({
    required this.name,
    required this.phone,
    required this.specialization,
    required this.icon,
  });

Future<void> _openWhatsApp() async {
  final url = Uri.parse("https://wa.me/$phone");

  try {
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    debugPrint("Tidak bisa membuka WhatsApp: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xFFEAF8F0),
                  child: Icon(
                    icon,
                    size: 30,
                    color: CounselorScreen.primaryColor,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        specialization,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "Online",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Klik tombol di bawah untuk memulai konsultasi melalui WhatsApp dengan $name.",
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _openWhatsApp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF25D366),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(
                  Icons.chat,
                  color: Colors.white,
                ),
                label: const Text(
                  "Hubungi via WhatsApp",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}