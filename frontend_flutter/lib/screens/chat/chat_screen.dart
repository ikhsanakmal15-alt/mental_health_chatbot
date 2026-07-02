import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../services/api_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final FlutterTts tts = FlutterTts();

  bool isTyping = false;

  final List<Map<String, dynamic>> messages = [];

  final List<String> suggestions = [
    "Halo Chatbot 👋",
    "Banyak deadline 📚",
    "Saya stres menghadapi ujian",
    "Tolong beri saya saran",
  ];

  final Color bg = const Color(0xFF120A25);
  final Color card = const Color(0xFF1E1533);
  final Color purple = const Color(0xFF8B5CFF);

  Future<void> sendMessage([String? text]) async {
    String msg = text ?? controller.text.trim();
    if (msg.isEmpty) return;

    setState(() {
      messages.add({"sender": "user", "text": msg});
      isTyping = true;
    });

    controller.clear();

    try {
      final reply = await ApiService.sendMessage(msg);

      await tts.setLanguage("id-ID");
      await tts.speak(reply);

      setState(() {
        messages.add({"sender": "bot", "text": reply});
        isTyping = false;
      });
    } catch (e) {
      setState(() {
        isTyping = false;
        messages.add({
          "sender": "bot",
          "text": "Maaf, sistem belum tersedia."
        });
      });
    }

    scrollToBottom();
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget botAvatar() {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFF8B5CFF), Color(0xFFB388FF)],
        ),
      ),
      child: const Icon(Icons.smart_toy, color: Colors.white, size: 18),
    );
  }

  Widget bubble(String text, bool isUser) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      decoration: BoxDecoration(
        color: isUser ? purple : card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          height: 1.4,
          fontSize: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "MindCare AI",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),

      body: Stack(
        children: [

          /// ================= BACKGROUND IMAGE =================
          Positioned.fill(
            child: Image.asset(
              "assets/images/mountain.png",
              fit: BoxFit.cover,
            ),
          ),

          /// DARK OVERLAY BIAR TETAP READABLE
          Positioned.fill(
            child: Container(
              color: const Color(0xFF120A25).withOpacity(0.88),
            ),
          ),

          /// ================= CONTENT =================
          Column(
            children: [

              /// ================= HEADER =================
              Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2A1B4A), Color(0xFF1C1233)],
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.06),
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Color(0xFFB388FF),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "Aku di sini untuk mendengarkan kamu dan membantu kamu merasa lebih baik.",
                        style: TextStyle(
                          color: Colors.white70,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// ================= CHAT =================
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(12),
                  itemCount: messages.length,
                  itemBuilder: (context, i) {
                    final msg = messages[i];
                    final isUser = msg["sender"] == "user";

                    return Row(
                      mainAxisAlignment: isUser
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!isUser) botAvatar(),
                        const SizedBox(width: 8),
                        bubble(msg["text"], isUser),
                      ],
                    );
                  },
                ),
              ),

              /// ================= TYPING =================
              if (isTyping)
                const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 6),
                  child: Row(
                    children: [
                      Icon(Icons.smart_toy, color: Colors.white38, size: 18),
                      SizedBox(width: 8),
                      Text(
                        "AI sedang mengetik...",
                        style: TextStyle(color: Colors.white38),
                      ),
                    ],
                  ),
                ),

              /// ================= SUGGESTIONS =================
              SizedBox(
                height: 46,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: suggestions.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () => sendMessage(suggestions[i]),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: card.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Center(
                          child: Text(
                            suggestions[i],
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// ================= INPUT =================
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: card.withOpacity(0.95),
                  border: Border.all(color: Colors.white10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Tulis perasaanmu...",
                          hintStyle: const TextStyle(color: Colors.white38),
                          filled: true,
                          fillColor: bg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => sendMessage(),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Color(0xFF8B5CFF), Color(0xFFB388FF)],
                          ),
                        ),
                        child: const Icon(Icons.send, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}