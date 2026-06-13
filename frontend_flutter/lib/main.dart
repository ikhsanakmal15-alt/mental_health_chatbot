import 'package:flutter/material.dart';

import 'screens/splash/splash_screen.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// ================= THEME =================
      theme: AppTheme.lightTheme,

      /// ================= HOME =================
      home: const SplashScreen(),
    );
  }
}