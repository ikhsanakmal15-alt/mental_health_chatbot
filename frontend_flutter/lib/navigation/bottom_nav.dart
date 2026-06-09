import 'package:flutter/material.dart';

import '../screens/home/home_screen.dart';
import '../screens/chat/chat_screen.dart';
import '../screens/tips/tips_screen.dart';
import '../screens/history/history_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;

  final primaryColor = const Color(0xFF6FCF97);
  final backgroundColor = const Color(0xFFF8FAFC);

  late final List<Widget> pages = [
    const HomeScreen(),
    const ChatScreen(),
    const TipsScreen(),
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      /// ================= BOTTOM NAV =================
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
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

          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,

          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),

          showUnselectedLabels: true,

          backgroundColor: Colors.white,

          elevation: 0,

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