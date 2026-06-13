import 'package:flutter/material.dart';

import '../../models/chat_history.dart';
import '../../services/history_service.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() =>
      _HistoryScreenState();
}

class _HistoryScreenState
    extends State<HistoryScreen> {
  List<ChatHistory> histories = [];
  List<ChatHistory> filteredHistories =
      [];

  final TextEditingController
      searchController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  Future<void> loadHistory() async {
    histories =
        await HistoryService.getHistories();

    filteredHistories = histories;

    setState(() {});
  }

  void searchHistory(String query) {
    if (query.isEmpty) {
      filteredHistories = histories;
    } else {
      filteredHistories = histories
          .where(
            (item) =>
                item.userMessage
                    .toLowerCase()
                    .contains(
                      query.toLowerCase(),
                    ) ||
                item.botResponse
                    .toLowerCase()
                    .contains(
                      query.toLowerCase(),
                    ),
          )
          .toList();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF8FAFC),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor:
            Colors.black87,
        title: const Text(
          "Riwayat Percakapan",
          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [
          /// HEADER
          Container(
            margin:
                const EdgeInsets.all(
                    16),
            padding:
                const EdgeInsets.all(
                    16),
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
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor:
                      Colors.white,
                  child: Icon(
                    Icons.history,
                    color:
                        Color(0xFF6FCF97),
                  ),
                ),
                const SizedBox(
                    width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      const Text(
                        "Riwayat Konsultasi",
                        style: TextStyle(
                          color:
                              Colors.white,
                          fontSize: 16,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                      Text(
                        "${histories.length} percakapan tersimpan",
                        style:
                            const TextStyle(
                          color:
                              Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// SEARCH BAR
          Padding(
            padding:
                const EdgeInsets
                    .symmetric(
              horizontal: 16,
            ),
            child: TextField(
              controller:
                  searchController,
              onChanged:
                  searchHistory,
              decoration:
                  InputDecoration(
                hintText:
                    "Cari riwayat percakapan...",
                prefixIcon:
                    const Icon(
                  Icons.search,
                ),
                filled: true,
                fillColor:
                    Colors.white,
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius
                          .circular(
                              18),
                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          Expanded(
            child: filteredHistories
                    .isEmpty
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
                            Icons.history,
                            size: 60,
                            color: Color(
                                0xFF6FCF97),
                          ),
                        ),

                        const SizedBox(
                            height: 15),

                        const Text(
                          "Belum Ada Riwayat",
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
                          "Mulai chat dengan MindCare agar percakapan tersimpan 🌿",
                          textAlign:
                              TextAlign
                                  .center,
                          style:
                              TextStyle(
                            color: Colors
                                .grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets
                            .all(16),
                    itemCount:
                        filteredHistories
                            .length,
                    itemBuilder:
                        (context,
                            index) {
                      final item =
                          filteredHistories[
                              index];

                      return Container(
                        margin:
                            const EdgeInsets
                                .only(
                          bottom: 15,
                        ),
                        decoration:
                            BoxDecoration(
                          color:
                              Colors.white,
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
                        child: ListTile(
                          contentPadding:
                              const EdgeInsets
                                  .all(
                                      14),

                          leading:
                              const CircleAvatar(
                            radius: 25,
                            backgroundColor:
                                Color(
                                    0xFFEAF8F0),
                            child: Icon(
                              Icons
                                  .smart_toy,
                              color: Color(
                                  0xFF6FCF97),
                            ),
                          ),

                          title: Text(
                            item.userMessage,
                            maxLines: 1,
                            overflow:
                                TextOverflow
                                    .ellipsis,
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),

                          subtitle:
                              Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              const SizedBox(
                                  height:
                                      6),

                              Text(
                                item.botResponse,
                                maxLines:
                                    2,
                                overflow:
                                    TextOverflow.ellipsis,
                              ),

                              const SizedBox(
                                  height:
                                      8),

                              Row(
                                children: [
                                  const Icon(
                                    Icons
                                        .access_time,
                                    size:
                                        14,
                                    color:
                                        Colors.grey,
                                  ),
                                  const SizedBox(
                                      width:
                                          4),
                                  Expanded(
                                    child:
                                        Text(
                                      item.createdAt,
                                      style:
                                          const TextStyle(
                                        fontSize:
                                            11,
                                        color:
                                            Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          trailing:
                              const Icon(
                            Icons
                                .arrow_forward_ios,
                            size: 16,
                            color:
                                Colors.grey,
                          ),

                          onTap: () {
                            showModalBottomSheet(
                              context:
                                  context,
                              isScrollControlled:
                                  true,
                              shape:
                                  const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.vertical(
                                  top:
                                      Radius.circular(
                                          25),
                                ),
                              ),
                              builder:
                                  (_) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.all(
                                          20),
                                  child:
                                      SingleChildScrollView(
                                    child:
                                        Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Detail Percakapan",
                                          style:
                                              TextStyle(
                                            fontSize:
                                                20,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(
                                            height:
                                                20),

                                        const Text(
                                          "Mahasiswa",
                                          style:
                                              TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(
                                            height:
                                                8),

                                        Text(
                                          item.userMessage,
                                        ),

                                        const Divider(
                                          height:
                                              30,
                                        ),

                                        const Text(
                                          "MindCare",
                                          style:
                                              TextStyle(
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(
                                            height:
                                                8),

                                        Text(
                                          item.botResponse,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}