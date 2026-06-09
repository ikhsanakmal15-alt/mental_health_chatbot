import 'package:flutter/material.dart';

class CounselorScreen extends StatelessWidget {
  const CounselorScreen({super.key});

  static const primaryColor = Color(0xFF6FCF97);
  static const backgroundColor = Color(0xFFF8FAFC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      /// ================= APP BAR =================
      appBar: AppBar(
        title: const Text(
          "Bantuan Konselor",
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

          /// ================= HEADER INFO =================
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF8F0),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.support_agent,
                  color: Color(0xFF6FCF97),
                  size: 40,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Kamu bisa menghubungi konselor jika membutuhkan bantuan profesional 🌿",
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

          /// ================= COUNSELOR CARD =================
          _CounselorCard(
            name: "Konselor Kampus",
            phone: "08123456789",
            specialization: "Kesehatan Mental Mahasiswa",
            icon: Icons.person_outline,
          ),

          const SizedBox(height: 12),

          _CounselorCard(
            name: "Psikolog Universitas",
            phone: "08234567890",
            specialization: "Konseling Akademik & Emosi",
            icon: Icons.psychology_outlined,
          ),
        ],
      ),
    );
  }
}

/// ================= REUSABLE CARD =================
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
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  specialization,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  phone,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6FCF97),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.phone,
            color: Color(0xFF6FCF97),
          ),
        ],
      ),
    );
  }
}