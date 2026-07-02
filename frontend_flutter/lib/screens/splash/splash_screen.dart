import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Stack(
        children: [

          /// ================= BACKGROUND GLOW =================
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, -0.3),
                radius: 1.2,
                colors: [
                  Color(0xFF2A1B4D),
                  Color(0xFF0B0B12),
                ],
              ),
            ),
          ),

          /// ================= CENTER CONTENT =================
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),

              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),

                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 35,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white10,
                    ),
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      /// ================= ICON =================
                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.primaryLight,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.4),
                              blurRadius: 30,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.psychology_alt_rounded,
                          size: 55,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// ================= TITLE =================
                      const Text(
                        "MindCare",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Teman Curhat Mahasiswa",
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// ================= LOADING =================
                      const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}