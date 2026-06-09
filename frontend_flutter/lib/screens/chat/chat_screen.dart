import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class ChatScreen extends StatefulWidget {

  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() =>
      _ChatScreenState();
}

class _ChatScreenState
    extends State<ChatScreen> {

  final List<Map<String, dynamic>>
      messages = [];

  final TextEditingController
      controller =
      TextEditingController();

  final ScrollController
      scrollController =
      ScrollController();

  static const primaryColor =
      Color(0xFF6FCF97);

  static const backgroundColor =
      Color(0xFFF8FAFC);

  Future<void> sendMessage() async {

    if (controller.text
        .trim()
        .isEmpty) return;

    String userMessage =
        controller.text.trim();

    setState(() {

      messages.add({
        "sender": "user",
        "text": userMessage,
      });

    });

    controller.clear();

    try {

      String botReply =
          await ApiService
              .sendMessage(
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
              "Tidak dapat terhubung ke server.",
        });

      });

    }

    Future.delayed(
      const Duration(
          milliseconds: 100),
      () {

        if (scrollController
            .hasClients) {

          scrollController.animateTo(
            scrollController
                .position
                .maxScrollExtent,
            duration:
                const Duration(
                    milliseconds:
                        300),
            curve:
                Curves.easeOut,
          );

        }

      },
    );
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      backgroundColor:
          backgroundColor,

      appBar: AppBar(

        title: const Text(
          "Chat AI Mental Health",
        ),

        centerTitle: true,

        backgroundColor:
            Colors.white,

        foregroundColor:
            Colors.black,

      ),

      body: Column(

        children: [

          Expanded(

            child:
                ListView.builder(

              controller:
                  scrollController,

              padding:
                  const EdgeInsets
                      .all(12),

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

                return Align(

                  alignment: isUser
                      ? Alignment
                          .centerRight
                      : Alignment
                          .centerLeft,

                  child: Container(

                    margin:
                        const EdgeInsets
                            .symmetric(
                      vertical: 4,
                    ),

                    padding:
                        const EdgeInsets
                            .all(12),

                    decoration:
                        BoxDecoration(

                      color: isUser
                          ? primaryColor
                          : Colors.white,

                      borderRadius:
                          BorderRadius
                              .circular(
                                  16),

                    ),

                    child: Text(

                      msg["text"],

                      style:
                          TextStyle(

                        color:
                            isUser
                                ? Colors
                                    .white
                                : Colors
                                    .black87,

                      ),

                    ),

                  ),

                );

              },

            ),

          ),

          Container(

            padding:
                const EdgeInsets
                    .all(10),

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

                      border:
                          OutlineInputBorder(

                        borderRadius:
                            BorderRadius.circular(
                                20),

                      ),

                    ),

                  ),

                ),

                const SizedBox(
                  width: 8,
                ),

                CircleAvatar(

                  backgroundColor:
                      primaryColor,

                  child:
                      IconButton(

                    icon:
                        const Icon(
                      Icons.send,
                      color:
                          Colors.white,
                    ),

                    onPressed:
                        sendMessage,

                  ),

                )

              ],

            ),

          )

        ],

      ),

    );
  }
}