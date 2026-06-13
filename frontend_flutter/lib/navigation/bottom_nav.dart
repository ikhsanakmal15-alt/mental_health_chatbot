import 'package:flutter/material.dart';

import '../screens/home/home_screen.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/tips/tips_screen.dart';
import '../screens/history/history_screen.dart';

class BottomNav extends StatefulWidget {
  final String userName;

  const BottomNav({
    super.key,
    required this.userName,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  static const Color primaryColor = Color(0xFF6FCF97);

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      HomeScreen(
        userName: widget.userName,
      ),
      const ChatScreen(),
      const TipsScreen(),
      const HistoryScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      /// ================= MODERN BOTTOM NAV =================
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),

        child: BottomNavigationBar(
          currentIndex: currentIndex,

          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },

          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.transparent,

          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey.shade400,

          selectedFontSize: 12,
          unselectedFontSize: 11,

          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),

          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
          ),

          showUnselectedLabels: true,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              activeIcon: Icon(Icons.chat_bubble),
              label: "Chat",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb_outline),
              activeIcon: Icon(Icons.lightbulb),
              label: "Tips",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              activeIcon: Icon(Icons.history),
              label: "Riwayat",
            ),
          ],
        ),
      ),
    );
  }
}