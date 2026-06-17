import 'package:flutter/material.dart';

import '../chat/chat_screen.dart';
import '../tips/tips_screen.dart';
import '../history/history_screen.dart';
import '../counselor/counselor_screen.dart';
import '../article/article_screen.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/home_menu_card.dart';

class HomeScreen extends StatelessWidget {
  final String userName;

  const HomeScreen({
    super.key,
    required this.userName,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),

          children: [
            /// ================= HEADER =================
            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.secondary,
                  ],
                ),

                borderRadius:
                    BorderRadius.circular(25),
              ),

              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor:
                        Colors.white,

                    child: Icon(
                      Icons.person,
                      color:
                          AppColors.primary,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [
                      Text(
                        "Halo ${userName.isEmpty ? 'Mahasiswa' : userName} 👋",
                          style:
                              const TextStyle(
                            color:
                                Colors.white,
                            fontSize: 22,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        const SizedBox(
                            height: 4),

                        const Text(
                          "Bagaimana perasaanmu hari ini? 🌿",
                          style:
                              TextStyle(
                            color:
                                Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons
                        .notifications_none,
                    color: Colors.white,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// ================= MOOD TRACKER =================
            Container(
              padding:
                  const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(
                        20),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(.05),
                    blurRadius: 10,
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  const Text(
                    "Mood Hari Ini 😊",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceAround,

                    children: const [
                      Text("😔",
                          style: TextStyle(
                              fontSize: 30)),
                      Text("😐",
                          style: TextStyle(
                              fontSize: 30)),
                      Text("🙂",
                          style: TextStyle(
                              fontSize: 30)),
                      Text("😄",
                          style: TextStyle(
                              fontSize: 30)),
                      Text("🤩",
                          style: TextStyle(
                              fontSize: 30)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            /// ================= FITUR =================
            const Text(
              "Fitur Utama",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            GridView(
              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.15,
              ),

              children: [
                HomeMenuCard(
                  title: "Chat AI",
                  subtitle:
                      "Curhat & Konsultasi",

                  icon:
                      Icons.chat_bubble_outline,

                  color:
                      const Color(0xFFEAF8F0),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const ChatScreen(),
                      ),
                    );
                  },
                ),

                HomeMenuCard(
                  title: "Tips Mental",
                  subtitle:
                      "Edukasi & Kesehatan",

                  icon:
                      Icons.lightbulb_outline,

                  color:
                      const Color(0xFFFFF5DD),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const TipsScreen(),
                      ),
                    );
                  },
                ),

                HomeMenuCard(
                  title: "Riwayat",
                  subtitle:
                      "Percakapan kamu",

                  icon: Icons.history,

                  color:
                      const Color(0xFFEAF7FF),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const HistoryScreen(),
                      ),
                    );
                  },
                ),

                HomeMenuCard(
                  title: "Konselor",
                  subtitle:
                      "Bantuan Profesional",

                  icon:
                      Icons.people_outline,

                  color:
                      const Color(0xFFF8EEFF),

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const CounselorScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 25),

            /// ================= ARTIKEL =================
            const Text(
              "Artikel Pilihan 📚",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _ArticleCard(
              image: "assets/images/anxiety.jpg",

              title: "Mengelola Anxiety Saat Kuliah",

              subtitle:
                  "Kecemasan terhadap tugas, ujian, dan tuntutan akademik dapat memengaruhi fokus serta kesehatan mental mahasiswa.",
            ),

            _ArticleCard(
              image: "assets/images/burnout.jpg",

              title: "Mengenali dan Mencegah Burnout",

              subtitle:
                  "Kelelahan fisik dan mental yang berkepanjangan dapat menurunkan motivasi belajar dan produktivitas sehari-hari.",
            ),

            _ArticleCard(
              image:
                  "assets/images/overthinking.jpg",

              title:
                  "Cara Mengurangi Overthinking",

              subtitle:
                  "Teknik sederhana yang membantu pikiran lebih tenang dan fokus.",
            ),

            const SizedBox(height: 20),

            /// ================= MOTIVASI =================
            Container(
              padding:
                  const EdgeInsets.all(20),

              decoration: BoxDecoration(
                gradient:
                    const LinearGradient(
                  colors: [
                    Color(0xFFEAF8F0),
                    Color(0xFFEAF7FF),
                  ],
                ),

                borderRadius:
                    BorderRadius.circular(
                        20),
              ),

              child: const Column(
                children: [
                  Text(
                    "💡 Motivasi Hari Ini",
                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "\"Kamu tidak harus sempurna hari ini. Terus melangkah sedikit demi sedikit sudah merupakan kemajuan.\"",
                    textAlign:
                        TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;

  const _ArticleCard({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius:
          BorderRadius.circular(20),

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const ArticleScreen(),
          ),
        );
      },

      child: Container(
        margin:
            const EdgeInsets.only(bottom: 15),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 10,
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(
                top: Radius.circular(20),
              ),

              child: Image.asset(
                image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.all(15),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [
                  Text(
                    title,
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                      height: 8),

                  Text(
                    subtitle,
                    style:
                        const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(
                      height: 10),

                  const Text(
                    "Baca Selengkapnya →",
                    style: TextStyle(
                      color:
                          AppColors.primary,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}