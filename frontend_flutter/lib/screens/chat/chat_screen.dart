import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../services/api_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // ============================================================
  // CONTROLLERS
  // ============================================================

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FlutterTts tts = FlutterTts();

  // ============================================================
  // STATE
  // ============================================================

  bool isTyping = false;

  final List<Map<String, dynamic>> messages = [];

  // ============================================================
  // SUGGESTIONS
  // ============================================================

final List<String> suggestions = [
  "Halo 👋",                              // greet
  "Deadline tugas saya menumpuk 📚",     // stress_academic
  "Saya cemas menghadapi ujian 😟",      // anxiety
  "Saya kehilangan motivasi belajar 💭", // motivation
  "Saya tidak percaya diri 😔",           // self_confidence
  "Saya merasa kesepian 🫂",             // loneliness
  "Saya sulit tidur 😴",                  // sleep_problem
  "Saya stres mengerjakan skripsi 📖",   // inform / stress_academic
  "Apa yang harus saya lakukan? 💡",     // ask_tips
  "Saya ingin konsultasi 💬",            // consultation
];

  // ============================================================
  // COLORS
  // ============================================================

  static const Color bg = Color(0xFF090B20);
  static const Color purple = Color(0xFF7458FF);
  static const Color lightPurple = Color(0xFF9B78FF);
  static const Color cyan = Color(0xFF5EDBD5);
  static const Color card = Color(0xFF15132D);

  // ============================================================
  // SEND MESSAGE
  // ============================================================

  Future<void> sendMessage([String? text]) async {
    final String msg = text ?? controller.text.trim();

    // Jangan kirim pesan kosong atau ketika AI masih menjawab
    if (msg.isEmpty || isTyping) return;

    // ------------------------------------------------------------
    // TAMPILKAN PESAN USER TERLEBIH DAHULU
    // ------------------------------------------------------------

    setState(() {
      messages.add({
        "sender": "user",
        "text": msg,
      });

      isTyping = true;
    });

    controller.clear();

    // Scroll setelah pesan user muncul
    scrollToBottom();

    try {
      // ----------------------------------------------------------
      // REQUEST KE API
      // ----------------------------------------------------------

      final reply = await ApiService.sendMessage(msg);

      if (!mounted) return;

      // ----------------------------------------------------------
      // TAMPILKAN RESPONS BOT SEGERA
      // ----------------------------------------------------------

      setState(() {
        messages.add({
          "sender": "bot",
          "text": reply,
        });

        isTyping = false;
      });

      // Scroll setelah respons bot tampil
      scrollToBottom();

      // ----------------------------------------------------------
      // TTS
      // ----------------------------------------------------------
      // TTS dijalankan SETELAH bot tampil.
      // Jadi UI tidak menunggu TTS selesai.

      try {
        await tts.setLanguage("id-ID");
        await tts.setSpeechRate(0.48);
        await tts.setPitch(1.0);
        await tts.speak(reply);
      } catch (e) {
        debugPrint("TTS Error: $e");
      }
    } catch (e) {
      // ----------------------------------------------------------
      // ERROR
      // ----------------------------------------------------------

      if (!mounted) return;

      setState(() {
        isTyping = false;

        messages.add({
          "sender": "bot",
          "text": "Maaf, sistem belum tersedia.",
        });
      });

      scrollToBottom();

      debugPrint("Chat Error: $e");
    }
  }

  // ============================================================
  // SCROLL TO BOTTOM
  // ============================================================

  void scrollToBottom() {
    Future.delayed(
      const Duration(milliseconds: 150),
      () {
        if (!mounted) return;

        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
          );
        }
      },
    );
  }

  // ============================================================
  // BOT AVATAR
  // ============================================================

  Widget botAvatar() {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [
            Color(0xFFB65CFF),
            Color(0xFF7458FF),
            Color(0xFF5EDBD5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: purple.withValues(alpha: 0.28),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF101329),
        ),
        child: const Icon(
          Icons.psychology_rounded,
          color: Color(0xFFB77AFF),
          size: 20,
        ),
      ),
    );
  }

  // ============================================================
  // USER AVATAR
  // ============================================================

  Widget userAvatar() {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: purple.withValues(alpha: 0.18),
        border: Border.all(
          color: lightPurple.withValues(alpha: 0.25),
        ),
      ),
      child: const Icon(
        Icons.person_rounded,
        color: Color(0xFFBBA7FF),
        size: 18,
      ),
    );
  }

  // ============================================================
  // CHAT BUBBLE
  // ============================================================

  Widget bubble(
    String text,
    bool isUser,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      constraints: BoxConstraints(
        maxWidth:
            MediaQuery.of(context).size.width * 0.74,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        gradient: isUser
            ? const LinearGradient(
                colors: [
                  Color(0xFF7458FF),
                  Color(0xFF8B5CFF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.075),
                  Colors.white.withValues(alpha: 0.045),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(18),
          topRight: const Radius.circular(18),
          bottomLeft: Radius.circular(
            isUser ? 18 : 5,
          ),
          bottomRight: Radius.circular(
            isUser ? 5 : 18,
          ),
        ),
        border: isUser
            ? null
            : Border.all(
                color:
                    Colors.white.withValues(alpha: 0.08),
              ),
        boxShadow: [
          if (isUser)
            BoxShadow(
              color:
                  purple.withValues(alpha: 0.18),
              blurRadius: 12,
              spreadRadius: 1,
            ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          height: 1.45,
        ),
      ),
    );
  }

  // ============================================================
  // TYPING INDICATOR
  // ============================================================

  Widget typingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 8,
      ),
      child: Row(
        children: [
          botAvatar(),

          const SizedBox(width: 9),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color:
                  Colors.white.withValues(alpha: 0.055),
              borderRadius:
                  BorderRadius.circular(16),
              border: Border.all(
                color:
                    Colors.white.withValues(alpha: 0.07),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TypingDot(delay: 0),
                SizedBox(width: 4),
                _TypingDot(delay: 150),
                SizedBox(width: 4),
                _TypingDot(delay: 300),
              ],
            ),
          ),

          const SizedBox(width: 9),

          Text(
            "AI sedang mengetik...",
            style: TextStyle(
              color:
                  Colors.white.withValues(alpha: 0.38),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        12,
        8,
        12,
        4,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 15,
            sigmaY: 15,
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.085),
                  Colors.white.withValues(alpha: 0.045),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius:
                  BorderRadius.circular(22),
              border: Border.all(
                color:
                    Colors.white.withValues(alpha: 0.09),
              ),
            ),
            child: Row(
              children: [
                // Logo kecil
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFB65CFF),
                        Color(0xFF7458FF),
                        Color(0xFF5EDBD5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF101329),
                    ),
                    child: const Icon(
                      Icons.psychology_rounded,
                      color: Color(0xFFB77AFF),
                      size: 24,
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "MindCare AI",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),

                          const SizedBox(width: 7),

                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: cyan.withValues(
                                alpha: 0.12,
                              ),
                              borderRadius:
                                  BorderRadius.circular(
                                20,
                              ),
                            ),
                            child: const Text(
                              "ONLINE",
                              style: TextStyle(
                                color: Color(0xFF70DED8),
                                fontSize: 8,
                                fontWeight:
                                    FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "Teman untuk mendengarkan ceritamu",
                        style: TextStyle(
                          color: Colors.white
                              .withValues(alpha: 0.48),
                          fontSize: 11,
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
    );
  }

  // ============================================================
  // WELCOME CARD
  // ============================================================

  Widget welcomeCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        12,
        8,
        12,
        10,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF8B5CF6)
                .withValues(alpha: 0.13),
            const Color(0xFF5EDBD5)
                .withValues(alpha: 0.055),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              Colors.white.withValues(alpha: 0.07),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF9B78FF)
                  .withValues(alpha: 0.13),
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.favorite_rounded,
              color: Color(0xFFB77AFF),
              size: 20,
            ),
          ),

          const SizedBox(width: 11),

          const Expanded(
            child: Text(
              "Aku di sini untuk mendengarkan kamu. "
              "Ceritakan apa yang sedang kamu rasakan, "
              "tanpa perlu takut dihakimi.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SUGGESTIONS
  // ============================================================

  Widget suggestionsWidget() {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: isTyping
                ? null
                : () => sendMessage(
                      suggestions[index],
                    ),
            child: Container(
              margin:
                  const EdgeInsets.only(right: 9),
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                color: Colors.white
                    .withValues(alpha: 0.055),
                borderRadius:
                    BorderRadius.circular(22),
                border: Border.all(
                  color: Colors.white
                      .withValues(alpha: 0.08),
                ),
              ),
              child: Center(
                child: Text(
                  suggestions[index],
                  style: TextStyle(
                    color: Colors.white
                        .withValues(alpha: 0.62),
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // INPUT AREA
  // ============================================================

  Widget inputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        10,
        8,
        10,
        10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF101127)
            .withValues(alpha: 0.96),
        border: Border(
          top: BorderSide(
            color:
                Colors.white.withValues(alpha: 0.07),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                enabled: !isTyping,
                minLines: 1,
                maxLines: 4,
                textCapitalization:
                    TextCapitalization.sentences,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
                onSubmitted: (_) {
                  if (!isTyping) {
                    sendMessage();
                  }
                },
                decoration: InputDecoration(
                  hintText:
                      "Tulis perasaanmu...",
                  hintStyle: TextStyle(
                    color: Colors.white
                        .withValues(alpha: 0.32),
                    fontSize: 13,
                  ),
                  filled: true,
                  fillColor:
                      Colors.white.withValues(
                    alpha: 0.045,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(23),
                    borderSide: BorderSide(
                      color: Colors.white
                          .withValues(alpha: 0.06),
                    ),
                  ),
                  enabledBorder:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(23),
                    borderSide: BorderSide(
                      color: Colors.white
                          .withValues(alpha: 0.06),
                    ),
                  ),
                  focusedBorder:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(23),
                    borderSide:
                        const BorderSide(
                      color: Color(0xFF7458FF),
                      width: 1.2,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            GestureDetector(
              onTap: isTyping
                  ? null
                  : () => sendMessage(),
              child: AnimatedContainer(
                duration:
                    const Duration(milliseconds: 200),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isTyping
                      ? LinearGradient(
                          colors: [
                            Colors.white
                                .withValues(alpha: 0.08),
                            Colors.white
                                .withValues(alpha: 0.05),
                          ],
                        )
                      : const LinearGradient(
                          colors: [
                            Color(0xFF7458FF),
                            Color(0xFF9B78FF),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  boxShadow: isTyping
                      ? []
                      : [
                          BoxShadow(
                            color: purple
                                .withValues(
                              alpha: 0.30,
                            ),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ],
                ),
                child: Center(
                  child: isTyping
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white54,
                          ),
                        )
                      : const Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 21,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,

      // ==========================================================
      // APP BAR
      // ==========================================================

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
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
          "Chat",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // ==========================================================
      // BODY
      // ==========================================================

      body: Stack(
        children: [
          // -------------------------------------------------------
          // BACKGROUND
          // -------------------------------------------------------

          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(
                    0,
                    -0.55,
                  ),
                  radius: 1.25,
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
            ),
          ),

          // -------------------------------------------------------
          // PURPLE GLOW
          // -------------------------------------------------------

          Positioned(
            top: -100,
            right: -100,
            child: _GlowCircle(
              size: 260,
              color: const Color(0xFF8B5CF6),
            ),
          ),

          // -------------------------------------------------------
          // CYAN GLOW
          // -------------------------------------------------------

          Positioned(
            bottom: 120,
            left: -120,
            child: _GlowCircle(
              size: 250,
              color: const Color(0xFF5EDBD5),
            ),
          ),

          // -------------------------------------------------------
          // CONTENT
          // -------------------------------------------------------

          Column(
            children: [
              // Header
              buildHeader(),

              // Welcome
              welcomeCard(),

              // Chat
              Expanded(
                child: messages.isEmpty
                    ? _emptyChat()
                    : ListView.builder(
                        controller:
                            scrollController,
                        padding:
                            const EdgeInsets.fromLTRB(
                          12,
                          4,
                          12,
                          12,
                        ),
                        itemCount:
                            messages.length,
                        itemBuilder:
                            (context, index) {
                          final msg =
                              messages[index];

                          final bool isUser =
                              msg["sender"] ==
                                  "user";

                          return Row(
                            mainAxisAlignment:
                                isUser
                                    ? MainAxisAlignment
                                        .end
                                    : MainAxisAlignment
                                        .start,
                            crossAxisAlignment:
                                CrossAxisAlignment.end,
                            children: [
                              if (!isUser) ...[
                                botAvatar(),
                                const SizedBox(
                                  width: 7,
                                ),
                              ],

                              bubble(
                                msg["text"]
                                    .toString(),
                                isUser,
                              ),

                              if (isUser) ...[
                                const SizedBox(
                                  width: 7,
                                ),
                                userAvatar(),
                              ],
                            ],
                          );
                        },
                      ),
              ),

              // Typing
              if (isTyping)
                typingIndicator(),

              // Suggestions
              if (!isTyping)
                suggestionsWidget(),

              const SizedBox(height: 7),

              // Input
              inputArea(),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY CHAT
  // ============================================================

  Widget _emptyChat() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
        ),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFB65CFF),
                    Color(0xFF7458FF),
                    Color(0xFF5EDBD5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: purple.withValues(
                      alpha: 0.22,
                    ),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF101329),
                ),
                child: const Icon(
                  Icons.psychology_rounded,
                  color: Color(0xFFB77AFF),
                  size: 39,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Apa yang sedang kamu rasakan?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Ceritakan apa saja. Aku akan "
              "mendengarkan dan menemanimu.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color:
                    Colors.white.withValues(
                  alpha: 0.45,
                ),
                fontSize: 12,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 18),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.favorite_rounded,
                  color: Color(0xFFB77AFF),
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  "Kamu tidak harus menghadapi semuanya sendiri",
                  style: TextStyle(
                    color: Colors.white
                        .withValues(alpha: 0.35),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    tts.stop();
    super.dispose();
  }
}

// ==================================================================
// GLOW CIRCLE
// ==================================================================

class _GlowCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowCircle({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.05),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.09),
              blurRadius: 100,
              spreadRadius: 35,
            ),
          ],
        ),
      ),
    );
  }
}

// ==================================================================
// TYPING DOT
// ==================================================================

class _TypingDot extends StatefulWidget {
  final int delay;

  const _TypingDot({
    required this.delay,
  });

  @override
  State<_TypingDot> createState() =>
      _TypingDotState();
}

class _TypingDotState extends State<_TypingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0.25,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
      ),
      child: Container(
        width: 5,
        height: 5,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFB77AFF),
        ),
      ),
    );
  }
}