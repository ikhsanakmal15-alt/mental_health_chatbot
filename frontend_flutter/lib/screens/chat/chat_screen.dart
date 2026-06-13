import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() =>
      _ChatScreenState();
}

class _ChatScreenState
    extends State<ChatScreen> {
  final TextEditingController controller =
      TextEditingController();

  final ScrollController scrollController =
      ScrollController();

  final List<Map<String, dynamic>>
      messages = [];

  final List<String> suggestions = [
    "Halo Chatbot 👋",
    "Saya cemas 😔",
    "Banyak deadline 📚",
  ];

  Future<void> sendMessage(
      [String? text]) async {
    String userMessage =
        text ?? controller.text.trim();

    if (userMessage.isEmpty) return;

    setState(() {
      messages.add({
        "sender": "user",
        "text": userMessage,
      });
    });

    controller.clear();

    try {
      String botReply =
          await ApiService.sendMessage(
        userMessage,
      );

      setState(() {
        messages.add({
          "sender": "bot",
          "text": botReply,
        });
      });
    } catch (e) {
      setState(() {
        messages.add({
          "sender": "bot",
          "text":
              "Maaf, server sedang tidak dapat dihubungi.",
        });
      });
    }

    await Future.delayed(
      const Duration(milliseconds: 100),
    );

    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController
            .position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black87,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor:
                  Color(0xFFEAF8F0),
              child: Icon(
                Icons.smart_toy,
                color: Color(0xFF6FCF97),
                size: 18,
              ),
            ),
            SizedBox(width: 8),
            Text(
              "MindCare",
              style: TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          /// HEADER
          Container(
            margin:
                const EdgeInsets.all(15),
            padding:
                const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient:
                  const LinearGradient(
                colors: [
                  Color(0xFF6FCF97),
                  Color(0xFF56CCF2),
                ],
              ),
              borderRadius:
                  BorderRadius.circular(
                      20),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor:
                      Colors.white,
                  child: Icon(
                    Icons.smart_toy,
                    color:
                        Color(0xFF6FCF97),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Hai 👋 Ceritakan apa yang sedang kamu rasakan hari ini. Aku siap mendengarkan.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// KEYWORD REKOMENDASI
          SizedBox(
            height: 42,
            child: ListView(
              scrollDirection:
                  Axis.horizontal,
              children:
                  suggestions.map((text) {
                return Padding(
                  padding:
                      const EdgeInsets
                          .only(
                    left: 10,
                  ),
                  child: ActionChip(
                    backgroundColor:
                        const Color(
                            0xFFEAF8F0),
                    label: Text(text),
                    onPressed: () =>
                        sendMessage(text),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 10),

          /// CHAT AREA
          Expanded(
            child: messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                      children: [
                        Container(
                          padding:
                              const EdgeInsets
                                  .all(
                                      25),
                          decoration:
                              const BoxDecoration(
                            color: Color(
                                0xFFEAF8F0),
                            shape:
                                BoxShape
                                    .circle,
                          ),
                          child:
                              const Icon(
                            Icons
                                .smart_toy,
                            size: 60,
                            color: Color(
                                0xFF6FCF97),
                          ),
                        ),
                        const SizedBox(
                            height: 15),
                        const Text(
                          "Belum ada percakapan",
                          style:
                              TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                        const SizedBox(
                            height: 5),
                        const Text(
                          "Mulai percakapan dengan MindCare 🌿",
                          style:
                              TextStyle(
                            color:
                                Colors
                                    .grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller:
                        scrollController,
                    padding:
                        const EdgeInsets
                            .all(15),
                    itemCount:
                        messages.length,
                    itemBuilder:
                        (context,
                            index) {
                      final msg =
                          messages[
                              index];

                      final isUser =
                          msg["sender"] ==
                              "user";

                      return Padding(
                        padding:
                            const EdgeInsets
                                .only(
                          bottom: 12,
                        ),
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          mainAxisAlignment:
                              isUser
                                  ? MainAxisAlignment
                                      .end
                                  : MainAxisAlignment
                                      .start,
                          children: [
                            if (!isUser)
                              Container(
                                margin:
                                    const EdgeInsets
                                        .only(
                                  right: 8,
                                ),
                                child:
                                    const CircleAvatar(
                                  backgroundColor:
                                      Color(
                                          0xFFEAF8F0),
                                  child:
                                      Icon(
                                    Icons
                                        .smart_toy,
                                    color:
                                        Color(
                                            0xFF6FCF97),
                                  ),
                                ),
                              ),

                            Flexible(
                              child:
                                  Container(
                                padding:
                                    const EdgeInsets
                                        .all(
                                            14),
                                decoration:
                                    BoxDecoration(
                                  color: isUser
                                      ? const Color(
                                          0xFF6FCF97)
                                      : Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(
                                          20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors
                                          .black
                                          .withOpacity(
                                              0.05),
                                      blurRadius:
                                          10,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  msg[
                                      "text"],
                                  style:
                                      TextStyle(
                                    color: isUser
                                        ? Colors.white
                                        : Colors.black87,
                                    height:
                                        1.5,
                                  ),
                                ),
                              ),
                            ),

                            if (isUser)
                              Container(
                                margin:
                                    const EdgeInsets
                                        .only(
                                  left: 8,
                                ),
                                child:
                                    const CircleAvatar(
                                  backgroundColor:
                                      Color(
                                          0xFF6FCF97),
                                  child:
                                      Icon(
                                    Icons
                                        .person,
                                    color:
                                        Colors
                                            .white,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          /// INPUT
          Container(
            padding:
                const EdgeInsets.all(
                    12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:
                        controller,
                    decoration:
                        InputDecoration(
                      hintText:
                          "Tulis perasaanmu...",
                      filled: true,
                      fillColor:
                          const Color(
                              0xFFF3F5F7),
                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(
                                30),
                        borderSide:
                            BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration:
                      const BoxDecoration(
                    shape:
                        BoxShape.circle,
                    gradient:
                        LinearGradient(
                      colors: [
                        Color(
                            0xFF6FCF97),
                        Color(
                            0xFF56CCF2),
                      ],
                    ),
                  ),
                  child: IconButton(
                    onPressed:
                        sendMessage,
                    icon: const Icon(
                      Icons.send,
                      color:
                          Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}