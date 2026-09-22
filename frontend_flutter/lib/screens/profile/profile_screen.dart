import 'dart:ui';

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String userName;
  final String userEmail;

  const ProfileScreen({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    final displayName =
        userName.trim().isEmpty ? "Mahasiswa" : userName.trim();

    final displayEmail =
        userEmail.trim().isEmpty
            ? "Email tidak tersedia"
            : userEmail.trim();

    return Scaffold(
      backgroundColor: const Color(0xFF090B20),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          "Profil Pengguna",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.55),
            radius: 1.35,
            colors: [
              Color(0xFF261650),
              Color(0xFF111333),
              Color(0xFF080A1D),
            ],
            stops: [
              0.0,
              0.48,
              1.0,
            ],
          ),
        ),

        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              30,
            ),

            children: [
              // =========================================================
              // PROFILE HEADER
              // =========================================================

              ClipRRect(
                borderRadius: BorderRadius.circular(26),

                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 15,
                    sigmaY: 15,
                  ),

                  child: Container(
                    padding: const EdgeInsets.all(24),

                    decoration: BoxDecoration(
                      color: Colors.white.withValues(
                        alpha: 0.055,
                      ),

                      borderRadius:
                          BorderRadius.circular(26),

                      border: Border.all(
                        color: Colors.white.withValues(
                          alpha: 0.09,
                        ),
                      ),
                    ),

                    child: Column(
                      children: [
                        // =================================================
                        // AVATAR
                        // =================================================

                        Container(
                          width: 92,
                          height: 92,

                          decoration: BoxDecoration(
                            shape: BoxShape.circle,

                            gradient:
                                const LinearGradient(
                              colors: [
                                Color(0xFFB65CFF),
                                Color(0xFF7458FF),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),

                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF8B5CF6,
                                ).withValues(
                                  alpha: 0.30,
                                ),
                                blurRadius: 25,
                                spreadRadius: 2,
                              ),
                            ],
                          ),

                          child: const Icon(
                            Icons.person_rounded,
                            color: Colors.white,
                            size: 48,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // =================================================
                        // NAMA
                        // =================================================

                        Text(
                          displayName,
                          textAlign: TextAlign.center,

                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // =================================================
                        // EMAIL
                        // =================================================

                        Text(
                          displayEmail,
                          textAlign: TextAlign.center,

                          style: TextStyle(
                            color: Colors.white.withValues(
                              alpha: 0.55,
                            ),
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // =================================================
                        // STATUS
                        // =================================================

                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),

                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF7DDC91,
                            ).withValues(
                              alpha: 0.12,
                            ),

                            borderRadius:
                                BorderRadius.circular(20),

                            border: Border.all(
                              color: const Color(
                                0xFF7DDC91,
                              ).withValues(
                                alpha: 0.20,
                              ),
                            ),
                          ),

                          child: const Row(
                            mainAxisSize:
                                MainAxisSize.min,

                            children: [
                              Icon(
                                Icons
                                    .verified_user_rounded,
                                color: Color(
                                  0xFF7DDC91,
                                ),
                                size: 15,
                              ),

                              SizedBox(width: 6),

                              Text(
                                "Pengguna Aktif",
                                style: TextStyle(
                                  color: Color(
                                    0xFF7DDC91,
                                  ),
                                  fontSize: 11,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // =========================================================
              // INFORMASI AKUN
              // =========================================================

              const Text(
                "Informasi Akun",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              _profileInfoCard(
                icon: Icons.person_outline_rounded,
                title: "Nama Pengguna",
                value: displayName,
                color: const Color(0xFF9B78FF),
              ),

              const SizedBox(height: 10),

              _profileInfoCard(
                icon: Icons.email_outlined,
                title: "Email",
                value: displayEmail,
                color: const Color(0xFF5EDBD5),
              ),

              const SizedBox(height: 10),

              _profileInfoCard(
                icon: Icons.school_outlined,
                title: "Status",
                value: "Mahasiswa",
                color: const Color(0xFFFFC857),
              ),

              const SizedBox(height: 24),

              // =========================================================
              // PRIVASI & KEAMANAN
              // =========================================================

              const Text(
                "Privasi & Keamanan",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 12),

              _menuCard(
                icon: Icons.privacy_tip_outlined,
                title: "Kebijakan Privasi",
                subtitle:
                    "Informasi mengenai penggunaan dan pengelolaan data",
                color: const Color(0xFFB77AFF),
                onTap: () {
                  _showPrivacyDialog(context);
                },
              ),

              const SizedBox(height: 10),

              _menuCard(
                icon: Icons.lock_outline_rounded,
                title: "Keamanan Data",
                subtitle:
                    "Informasi mengenai keamanan data pengguna",
                color: const Color(0xFF7DDC91),
                onTap: () {
                  _showSecurityDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // PROFILE INFO CARD
  // ===========================================================

  Widget _profileInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.055,
        ),

        borderRadius:
            BorderRadius.circular(18),

        border: Border.all(
          color: Colors.white.withValues(
            alpha: 0.08,
          ),
        ),
      ),

      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,

            decoration: BoxDecoration(
              color: color.withValues(
                alpha: 0.13,
              ),

              borderRadius:
                  BorderRadius.circular(13),
            ),

            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: TextStyle(
                    color: Colors.white.withValues(
                      alpha: 0.45,
                    ),
                    fontSize: 11,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
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

  // ===========================================================
  // MENU CARD
  // ===========================================================

  Widget _menuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: Colors.white.withValues(
            alpha: 0.055,
          ),

          borderRadius:
              BorderRadius.circular(18),

          border: Border.all(
            color: Colors.white.withValues(
              alpha: 0.08,
            ),
          ),
        ),

        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,

              decoration: BoxDecoration(
                color: color.withValues(
                  alpha: 0.13,
                ),

                borderRadius:
                    BorderRadius.circular(13),
              ),

              child: Icon(
                icon,
                color: color,
                size: 22,
              ),
            ),

            const SizedBox(width: 13),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    title,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,

                    style: TextStyle(
                      color: Colors.white.withValues(
                        alpha: 0.42,
                      ),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFFB77AFF),
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================
  // PRIVACY DIALOG
  // ===========================================================

  void _showPrivacyDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor:
              const Color(0xFF17152F),

          title: const Text(
            "Kebijakan Privasi",

            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),

          content: const Text(
            "Informasi pengguna dan percakapan digunakan "
            "untuk mendukung fungsi aplikasi. Hindari "
            "memberikan informasi pribadi yang sangat "
            "sensitif melalui chatbot.",
            style: TextStyle(
              color: Colors.white70,
              height: 1.5,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                "Mengerti",

                style: TextStyle(
                  color: Color(0xFFB77AFF),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ===========================================================
  // SECURITY DIALOG
  // ===========================================================

  void _showSecurityDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor:
              const Color(0xFF17152F),

          title: const Text(
            "Keamanan Data",

            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),

          content: const Text(
            "Gunakan aplikasi dengan bijak dan hindari "
            "memasukkan informasi yang sangat sensitif "
            "ke dalam percakapan.",
            style: TextStyle(
              color: Colors.white70,
              height: 1.5,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                "Mengerti",

                style: TextStyle(
                  color: Color(0xFFB77AFF),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}