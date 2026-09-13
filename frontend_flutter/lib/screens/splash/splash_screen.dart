import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // ================= ANIMATION =================
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _animationController.forward();

    // ================= TIMER =================
    _timer = Timer(const Duration(seconds: 5), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090B20),
      body: Stack(
        children: [
          // =========================================================
          // BACKGROUND
          // =========================================================
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, -0.15),
                radius: 1.25,
                colors: [
                  Color(0xFF261650),
                  Color(0xFF111333),
                  Color(0xFF080A1D),
                ],
                stops: [
                  0.0,
                  0.55,
                  1.0,
                ],
              ),
            ),
          ),

          // =========================================================
          // PURPLE GLOW
          // =========================================================
          Positioned(
            top: 80,
            left: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF7C3AED).withValues(alpha: 0.12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.25),
                    blurRadius: 120,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 50,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6D28D9).withValues(alpha: 0.10),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.20),
                    blurRadius: 120,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),

          // =========================================================
          // DECORATIVE WAVES
          // =========================================================
          const Positioned(
            top: -30,
            left: -80,
            child: _WaveDecoration(
              rotation: -0.25,
            ),
          ),

          const Positioned(
            bottom: -30,
            right: -80,
            child: _WaveDecoration(
              rotation: 2.9,
            ),
          ),

          // =========================================================
          // CENTER CONTENT
          // =========================================================
          Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: child,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 20,
                      sigmaY: 20,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 45,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),

                        // Glass effect
                        color: Colors.white.withValues(alpha: 0.045),

                        border: Border.all(
                          color: const Color(0xFF8B7ACB)
                              .withValues(alpha: 0.35),
                          width: 1.5,
                        ),

                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF7C3AED)
                                .withValues(alpha: 0.15),
                            blurRadius: 40,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // =================================================
                          // LOGO
                          // =================================================
                          Container(
                            width: 190,
                            height: 190,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFB65CFF),
                                  Color(0xFF7458FF),
                                  Color(0xFF5EDBD5),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF8B5CF6)
                                      .withValues(alpha: 0.45),
                                  blurRadius: 45,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF101329),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Brain
                                  const Positioned(
                                    top: 25,
                                    child: Icon(
                                      Icons.psychology_rounded,
                                      size: 82,
                                      color: Color(0xFFB77AFF),
                                    ),
                                  ),

                                  // Chat bubble
                                  Positioned(
                                    bottom: 30,
                                    left: 20,
                                    child: Container(
                                      width: 95,
                                      height: 65,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(22),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF8B4DFF),
                                            Color(0xFF6155E8),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF8B5CF6)
                                                .withValues(alpha: 0.4),
                                            blurRadius: 20,
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            _Dot(),
                                            SizedBox(width: 7),
                                            _Dot(),
                                            SizedBox(width: 7),
                                            _Dot(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Face
                                  const Positioned(
                                    right: 18,
                                    bottom: 20,
                                    child: Icon(
                                      Icons.face_rounded,
                                      size: 100,
                                      color: Color(0xFF67DDD2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // =================================================
                          // TITLE
                          // =================================================
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Mind',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: -1,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Care',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF9B78FF),
                                    letterSpacing: -1,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 8),

                          // =================================================
                          // TAGLINE
                          // =================================================
                          const Text(
                            'Teman Curhat Mahasiswa',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white70,
                              letterSpacing: 0.3,
                            ),
                          ),

                          const SizedBox(height: 28),

                          // =================================================
                          // HEART DIVIDER
                          // =================================================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 75,
                                height: 1.5,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.transparent,
                                      const Color(0xFFA855F7)
                                          .withValues(alpha: 0.9),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(width: 15),

                              const Icon(
                                Icons.favorite_rounded,
                                size: 25,
                                color: Color(0xFFA855F7),
                              ),

                              const SizedBox(width: 15),

                              Container(
                                width: 75,
                                height: 1.5,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFFA855F7)
                                          .withValues(alpha: 0.9),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 35),

                          // =================================================
                          // LOADING
                          // =================================================
                          const SizedBox(
                            width: 48,
                            height: 48,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

// =============================================================
// DOT CHAT BUBBLE
// =============================================================

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}

// =============================================================
// DECORATIVE WAVE
// =============================================================

class _WaveDecoration extends StatelessWidget {
  final double rotation;

  const _WaveDecoration({
    required this.rotation,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: const SizedBox(
        width: 330,
        height: 330,
        child: CustomPaint(
          painter: _WavePainter(),
        ),
      ),
    );
  }
}

// =============================================================
// WAVE PAINTER
// =============================================================

class _WavePainter extends CustomPainter {
  const _WavePainter();

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0xFF7C3AED).withValues(alpha: 0.25);

    for (int i = 0; i < 10; i++) {
      final path = Path();
      final offset = i * 15.0;

      path.moveTo(
        -20,
        100 + offset,
      );

      path.cubicTo(
        80,
        20 + offset,
        170,
        180 + offset,
        350,
        60 + offset,
      );

      canvas.drawPath(
        path,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}