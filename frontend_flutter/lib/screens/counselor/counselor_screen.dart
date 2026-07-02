import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_colors.dart';

class CounselorScreen extends StatelessWidget {
  const CounselorScreen({super.key});

  /// ================= WHATSAPP =================
  Future<void> openWhatsApp(String phone) async {
    final url = Uri.parse("https://wa.me/$phone");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  /// ================= INSTAGRAM =================
  Future<void> openInstagram() async {
    final url = Uri.parse("https://www.instagram.com/upa_bk_unm/");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Bantuan Konselor",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// ================= HEADER =================
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white10),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.support_agent, color: Colors.white, size: 40),
                SizedBox(height: 10),
                Text(
                  "Butuh Teman Bicara? 🌿",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Konselor siap membantu kamu menghadapi stres dan tekanan akademik.",
                  style: TextStyle(color: Colors.white60),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// ================= MOTIVASI =================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10),
            ),
            child: const Text(
              "💜 Tidak apa-apa meminta bantuan. Berbicara adalah langkah berani menuju pemulihan mental.",
              style: TextStyle(color: Colors.white70),
            ),
          ),

          const SizedBox(height: 16),

          /// ================= KONSELOR KAMPUS =================
          _CounselorCard(
            name: "Konselor Kampus",
            phone: "6287827912460",
            specialization: "Kesehatan Mental Mahasiswa",
            icon: Icons.person_outline,
            onTap: () => openWhatsApp("6287827912460"),
          ),

          /// ================= KONSELOR UNIVERSITAS =================
          _CounselorCard(
            name: "Psikolog Universitas",
            phone: "6287827912460",
            specialization: "Konseling Akademik & Emosi",
            icon: Icons.psychology_alt_outlined,
            onTap: () => openWhatsApp("6287827912460"),
          ),

          const SizedBox(height: 18),

          /// ================= INSTAGRAM =================
          GestureDetector(
            onTap: openInstagram,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.camera_alt, color: Colors.purpleAccent),
                  SizedBox(width: 10),
                  Text(
                    "@upa_bk_unm",
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// ================= INFO KAMPUS =================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white10),
            ),
            child: const Text(
              "📍 Bagi mahasiswa yang ingin berkonsultasi bisa datang langsung ke ruang UPT Layanan BK di lantai 12 Menara Pinisi UNM pada hari/jam kerja.",
              style: TextStyle(color: Colors.white70, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= CARD =================
class _CounselorCard extends StatelessWidget {
  final String name;
  final String phone;
  final String specialization;
  final IconData icon;
  final VoidCallback onTap;

  const _CounselorCard({
    required this.name,
    required this.phone,
    required this.specialization,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white10),
      ),

      child: Column(
        children: [

          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: AppColors.primary.withOpacity(0.2),
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      specialization,
                      style: const TextStyle(color: Colors.white60),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// BUTTON WA
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.chat),
              label: const Text("Chat WhatsApp"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}