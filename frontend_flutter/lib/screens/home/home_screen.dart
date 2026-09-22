import 'dart:ui';

import 'package:flutter/material.dart';

import '../chat/chat_screen.dart';
import '../tips/tips_screen.dart';
import '../history/history_screen.dart';
import '../counselor/counselor_screen.dart';
import '../article/article_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  final String userEmail;

  const HomeScreen({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedMood;

  // ===========================================================
  // OPEN PROFILE
  // ===========================================================

  void _openProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(
          userName: widget.userName,
          userEmail: widget.userEmail,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayName =
        widget.userName.trim().isEmpty
            ? "Mahasiswa"
            : widget.userName.trim();

    return Scaffold(
      backgroundColor: const Color(0xFF090B20),

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

        child: Stack(
          children: [
            // =========================================================
            // GLOW BACKGROUND
            // =========================================================

            Positioned(
              top: -100,
              right: -80,

              child: _GlowCircle(
                size: 250,
                color: const Color(0xFF8B5CF6),
              ),
            ),

            Positioned(
              bottom: 100,
              left: -120,

              child: _GlowCircle(
                size: 260,
                color: const Color(0xFF4DDDD3),
              ),
            ),

            // =========================================================
            // CONTENT
            // =========================================================

            SafeArea(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  14,
                  16,
                  30,
                ),

                children: [
                  // =====================================================
                  // HEADER
                  // =====================================================

                  _buildHeader(displayName),

                  const SizedBox(height: 18),

                  // =====================================================
                  // HERO
                  // =====================================================

                  _buildHero(),

                  const SizedBox(height: 20),

                  // =====================================================
                  // MOOD
                  // =====================================================

                  _buildMoodCard(),

                  const SizedBox(height: 24),

                  // =====================================================
                  // FITUR UTAMA
                  // =====================================================

                  _buildSectionTitle(
                    "Fitur Utama",
                    "Temukan ruang yang kamu butuhkan",
                  ),

                  const SizedBox(height: 12),

                  GridView.count(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),

                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.18,

                    children: [
                      _featureCard(
                        context,

                        title: "Chat AI",
                        subtitle:
                            "Teman untuk bercerita",
                        icon:
                            Icons.chat_bubble_rounded,
                        color:
                            const Color(0xFF9B78FF),
                        page:
                            const ChatScreen(),
                      ),

                      _featureCard(
                        context,

                        title: "Tips Mental",
                        subtitle:
                            "Rawat dirimu setiap hari",
                        icon:
                            Icons.lightbulb_rounded,
                        color:
                            const Color(0xFFFFC857),
                        page:
                            const TipsScreen(),
                      ),

                      _featureCard(
                        context,

                        title: "Riwayat",
                        subtitle:
                            "Lihat perjalananmu",
                        icon:
                            Icons.history_rounded,
                        color:
                            const Color(0xFF5EDBD5),
                        page:
                            const HistoryScreen(),
                      ),

                      _featureCard(
                        context,

                        title: "Konselor",
                        subtitle:
                            "Temukan bantuan profesional",
                        icon:
                            Icons.people_alt_rounded,
                        color:
                            const Color(0xFF7DDC91),
                        page:
                            const CounselorScreen(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 26),

                  // =====================================================
                  // ARTIKEL
                  // =====================================================

                  _buildSectionTitle(
                    "Artikel Pilihan",
                    "Baca sesuatu yang mungkin membantumu",
                  ),

                  const SizedBox(height: 12),

                  _articleCard(
                    context,

                    image:
                        "assets/images/anxiety.jpg",

                    title:
                        "Mengelola Anxiety Saat Kuliah",

                    subtitle:
                        "Tips menjaga fokus dan ketenangan pikiran",
                  ),

                  _articleCard(
                    context,

                    image:
                        "assets/images/overthinking.jpg",

                    title:
                        "Mengurangi Overthinking",

                    subtitle:
                        "Latihan sederhana untuk pikiran yang lebih tenang",
                  ),

                  _articleCard(
                    context,

                    image:
                        "assets/images/burnout.jpg",

                    title:
                        "Menghindari Burnout",

                    subtitle:
                        "Jaga energi agar tetap stabil setiap hari",
                  ),

                  const SizedBox(height: 12),

                  // =====================================================
                  // QUOTE
                  // =====================================================

                  _buildQuoteCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===================================================================
  // HEADER
  // ===================================================================

  Widget _buildHeader(String displayName) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),

      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 15,
          sigmaY: 15,
        ),

        child: Container(
          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(
                  alpha: 0.10,
                ),
                Colors.white.withValues(
                  alpha: 0.045,
                ),
              ],

              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),

            borderRadius:
                BorderRadius.circular(24),

            border: Border.all(
              color: Colors.white.withValues(
                alpha: 0.10,
              ),
            ),
          ),

          child: Row(
            children: [
              // =========================================================
              // AVATAR
              // =========================================================

              GestureDetector(
                onTap: _openProfile,

                child: Container(
                  width: 54,
                  height: 54,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    gradient:
                        const LinearGradient(
                      colors: [
                        Color(0xFFB65CFF),
                        Color(0xFF7458FF),
                      ],

                      begin:
                          Alignment.topLeft,
                      end:
                          Alignment.bottomRight,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: const Color(
                          0xFF8B5CF6,
                        ).withValues(
                          alpha: 0.30,
                        ),

                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),

                  child: const Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),

              const SizedBox(width: 13),

              // =========================================================
              // USER NAME
              // =========================================================

              Expanded(
                child: GestureDetector(
                  onTap: _openProfile,

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Selamat datang 👋",

                        style: TextStyle(
                          color:
                              Colors.white.withValues(
                            alpha: 0.65,
                          ),

                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        displayName,

                        maxLines: 1,

                        overflow:
                            TextOverflow.ellipsis,

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight:
                              FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // =========================================================
              // NOTIFICATION
              // =========================================================

              Container(
                width: 42,
                height: 42,

                decoration: BoxDecoration(
                  color:
                      Colors.white.withValues(
                    alpha: 0.07,
                  ),

                  borderRadius:
                      BorderRadius.circular(14),

                  border: Border.all(
                    color:
                        Colors.white.withValues(
                      alpha: 0.08,
                    ),
                  ),
                ),

                child: const Icon(
                  Icons
                      .notifications_none_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===================================================================
  // HERO
  // ===================================================================

  Widget _buildHero() {
    return Container(
      height: 185,

      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(26),

        boxShadow: [
          BoxShadow(
            color: const Color(
              0xFF8B5CF6,
            ).withValues(
              alpha: 0.16,
            ),

            blurRadius: 25,
            spreadRadius: 1,
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(26),

        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/mountain.png",
                fit: BoxFit.cover,
              ),
            ),

            // Dark overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration:
                    BoxDecoration(
                  gradient:
                      LinearGradient(
                    begin:
                        Alignment.topCenter,
                    end:
                        Alignment.bottomCenter,

                    colors: [
                      Colors.black.withValues(
                        alpha: 0.05,
                      ),

                      const Color(
                        0xFF090B20,
                      ).withValues(
                        alpha: 0.88,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Content
            Positioned(
              left: 20,
              right: 20,
              bottom: 18,

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),

                    decoration:
                        BoxDecoration(
                      color: const Color(
                        0xFF9B78FF,
                      ).withValues(
                        alpha: 0.20,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),

                      border: Border.all(
                        color: const Color(
                          0xFFB77AFF,
                        ).withValues(
                          alpha: 0.30,
                        ),
                      ),
                    ),

                    child: const Text(
                      "MINDCARE",

                      style: TextStyle(
                        color:
                            Color(0xFFD6C5FF),
                        fontSize: 10,
                        fontWeight:
                            FontWeight.w700,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 9),

                  const Text(
                    "Jaga Kesehatan Mentalmu",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Kamu berharga. Jangan lupa beri ruang untuk dirimu.",

                    style: TextStyle(
                      color:
                          Colors.white.withValues(
                        alpha: 0.70,
                      ),
                      fontSize: 12,
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

  // ===================================================================
  // MOOD CARD
  // ===================================================================

  Widget _buildMoodCard() {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(24),

      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 15,
          sigmaY: 15,
        ),

        child: Container(
          padding: const EdgeInsets.all(17),

          decoration: BoxDecoration(
            color: Colors.white.withValues(
              alpha: 0.055,
            ),

            borderRadius:
                BorderRadius.circular(24),

            border: Border.all(
              color: Colors.white.withValues(
                alpha: 0.09,
              ),
            ),
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,

                    decoration:
                        BoxDecoration(
                      color: const Color(
                        0xFF9B78FF,
                      ).withValues(
                        alpha: 0.15,
                      ),

                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),

                    child: const Icon(
                      Icons.favorite_rounded,
                      color:
                          Color(0xFFB77AFF),
                      size: 20,
                    ),
                  ),

                  const SizedBox(width: 11),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [
                        Text(
                          "Bagaimana perasaanmu?",

                          style: TextStyle(
                            color:
                                Colors.white,
                            fontSize: 15,
                            fontWeight:
                                FontWeight.w700,
                          ),
                        ),

                        SizedBox(height: 2),

                        Text(
                          "Ceritakan lewat mood hari ini",

                          style: TextStyle(
                            color:
                                Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 17),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                children: [
                  _moodButton(0, "😔"),
                  _moodButton(1, "😕"),
                  _moodButton(2, "😐"),
                  _moodButton(3, "🙂"),
                  _moodButton(4, "😍"),
                ],
              ),

              if (selectedMood != null) ...[
                const SizedBox(height: 13),

                Center(
                  child: AnimatedSwitcher(
                    duration:
                        const Duration(
                      milliseconds: 250,
                    ),

                    child: Text(
                      _getMoodName(
                        selectedMood!,
                      ),

                      key: ValueKey(
                        selectedMood,
                      ),

                      style:
                          const TextStyle(
                        color:
                            Color(0xFFB77AFF),
                        fontSize: 13,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ===================================================================
  // MOOD BUTTON
  // ===================================================================

  Widget _moodButton(
    int index,
    String emoji,
  ) {
    final isSelected =
        selectedMood == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMood = index;
        });

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.favorite_rounded,
                    color:
                        Color(0xFFB77AFF),
                    size: 18,
                  ),

                  const SizedBox(width: 8),

                  Text(
                    "Mood: ${_getMoodName(index)}",
                  ),
                ],
              ),

              duration:
                  const Duration(
                milliseconds: 1100,
              ),

              behavior:
                  SnackBarBehavior.floating,

              backgroundColor:
                  const Color(0xFF17152F),

              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),
            ),
          );
      },

      child: AnimatedContainer(
        duration:
            const Duration(
          milliseconds: 220,
        ),

        curve: Curves.easeOut,

        width: 50,
        height: 50,

        decoration: BoxDecoration(
          color: isSelected
              ? const Color(
                  0xFF8B5CF6,
                ).withValues(
                  alpha: 0.20,
                )
              : Colors.white.withValues(
                  alpha: 0.035,
                ),

          borderRadius:
              BorderRadius.circular(16),

          border: Border.all(
            color: isSelected
                ? const Color(
                    0xFF9B78FF,
                  )
                : Colors.white.withValues(
                    alpha: 0.06,
                  ),

            width:
                isSelected ? 1.5 : 1,
          ),

          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color:
                        const Color(
                      0xFF8B5CF6,
                    ).withValues(
                      alpha: 0.30,
                    ),

                    blurRadius: 16,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),

        child: Center(
          child: AnimatedScale(
            scale:
                isSelected ? 1.18 : 1.0,

            duration:
                const Duration(
              milliseconds: 220,
            ),

            child: Text(
              emoji,

              style:
                  const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===================================================================
  // SECTION TITLE
  // ===================================================================

  Widget _buildSectionTitle(
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Text(
          title,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight:
                FontWeight.w800,
          ),
        ),

        const SizedBox(height: 3),

        Text(
          subtitle,

          style: TextStyle(
            color:
                Colors.white.withValues(
              alpha: 0.45,
            ),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  // ===================================================================
  // FEATURE CARD
  // ===================================================================

  Widget _featureCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,

          MaterialPageRoute(
            builder: (_) => page,
          ),
        );
      },

      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(22),

        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 12,
            sigmaY: 12,
          ),

          child: Container(
            padding:
                const EdgeInsets.all(15),

            decoration: BoxDecoration(
              color:
                  Colors.white.withValues(
                alpha: 0.055,
              ),

              borderRadius:
                  BorderRadius.circular(22),

              border: Border.all(
                color:
                    Colors.white.withValues(
                  alpha: 0.08,
                ),
              ),
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Container(
                  width: 46,
                  height: 46,

                  decoration:
                      BoxDecoration(
                    color:
                        color.withValues(
                      alpha: 0.14,
                    ),

                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),

                    border: Border.all(
                      color:
                          color.withValues(
                        alpha: 0.16,
                      ),
                    ),
                  ),

                  child: Icon(
                    icon,
                    color: color,
                    size: 23,
                  ),
                ),

                const Spacer(),

                Text(
                  title,

                  style:
                      const TextStyle(
                    color:
                        Colors.white,
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  subtitle,

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style: TextStyle(
                    color:
                        Colors.white
                            .withValues(
                      alpha: 0.42,
                    ),

                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===================================================================
  // ARTICLE CARD
  // ===================================================================

  Widget _articleCard(
    BuildContext context, {
    required String image,
    required String title,
    required String subtitle,
  }) {
    return GestureDetector(
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
            const EdgeInsets.only(
          bottom: 12,
        ),

        decoration: BoxDecoration(
          color:
              Colors.white.withValues(
            alpha: 0.055,
          ),

          borderRadius:
              BorderRadius.circular(20),

          border: Border.all(
            color:
                Colors.white.withValues(
              alpha: 0.08,
            ),
          ),
        ),

        child: Padding(
          padding:
              const EdgeInsets.all(8),

          child: Row(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(
                  15,
                ),

                child: Image.asset(
                  image,

                  width: 82,
                  height: 82,

                  fit: BoxFit.cover,
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

                      maxLines: 2,

                      overflow:
                          TextOverflow.ellipsis,

                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontSize: 13,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      subtitle,

                      maxLines: 2,

                      overflow:
                          TextOverflow.ellipsis,

                      style: TextStyle(
                        color:
                            Colors.white
                                .withValues(
                          alpha: 0.45,
                        ),

                        fontSize: 11,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Container(
                width: 34,
                height: 34,

                decoration:
                    BoxDecoration(
                  color:
                      const Color(
                    0xFF9B78FF,
                  ).withValues(
                    alpha: 0.10,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    11,
                  ),
                ),

                child: const Icon(
                  Icons
                      .arrow_forward_ios_rounded,

                  color:
                      Color(0xFFB77AFF),

                  size: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===================================================================
  // QUOTE CARD
  // ===================================================================

  Widget _buildQuoteCard() {
    return Container(
      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(
        gradient:
            LinearGradient(
          colors: [
            const Color(
              0xFF8B5CF6,
            ).withValues(
              alpha: 0.16,
            ),

            const Color(
              0xFF5EDBD5,
            ).withValues(
              alpha: 0.07,
            ),
          ],

          begin:
              Alignment.topLeft,
          end:
              Alignment.bottomRight,
        ),

        borderRadius:
            BorderRadius.circular(22),

        border: Border.all(
          color:
              Colors.white.withValues(
            alpha: 0.08,
          ),
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Container(
            width: 38,
            height: 38,

            decoration:
                BoxDecoration(
              color:
                  const Color(
                0xFF9B78FF,
              ).withValues(
                alpha: 0.14,
              ),

              borderRadius:
                  BorderRadius.circular(
                12,
              ),
            ),

            child: const Icon(
              Icons.format_quote_rounded,

              color:
                  Color(0xFFB77AFF),
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Text(
              "Tidak apa-apa untuk berjalan pelan. "
              "Yang penting, kamu tetap melangkah.",

              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                height: 1.5,
                fontWeight:
                    FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===================================================================
  // MOOD NAME
  // ===================================================================

  String _getMoodName(
    int index,
  ) {
    const moods = [
      "Sedih",
      "Kurang baik",
      "Biasa saja",
      "Senang",
      "Sangat senang",
    ];

    return moods[index];
  }
}

// =====================================================================
// GLOW CIRCLE
// =====================================================================

class _GlowCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowCircle({
    required this.size,
    required this.color,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,

        decoration:
            BoxDecoration(
          shape: BoxShape.circle,

          color:
              color.withValues(
            alpha: 0.06,
          ),

          boxShadow: [
            BoxShadow(
              color:
                  color.withValues(
                alpha: 0.10,
              ),

              blurRadius: 100,
              spreadRadius: 35,
            ),
          ],
        ),
      ),
    );
  }
}