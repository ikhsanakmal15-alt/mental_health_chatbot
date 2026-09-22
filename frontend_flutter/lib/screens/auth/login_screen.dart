import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_colors.dart';
import '../../navigation/bottom_nav.dart';
import '../../services/auth_service.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // =========================================================
  // LOGIN
  // =========================================================

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // ---------------------------------------------------------
    // VALIDASI INPUT
    // ---------------------------------------------------------

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email dan password wajib diisi"),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // -------------------------------------------------------
      // REQUEST LOGIN
      // -------------------------------------------------------

      final result = await AuthService.login(
        email,
        password,
      );

      if (!mounted) return;

      // -------------------------------------------------------
      // SELESAI LOADING
      // -------------------------------------------------------

      setState(() {
        isLoading = false;
      });

      // -------------------------------------------------------
      // LOGIN GAGAL
      // -------------------------------------------------------

      if (result == null || result["access_token"] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Login gagal: email atau password salah",
            ),
          ),
        );
        return;
      }

      // -------------------------------------------------------
      // LOGIN BERHASIL
      // -------------------------------------------------------

      final user = result["user"];

      // -------------------------------------------------------
      // SIMPAN DATA USER
      // -------------------------------------------------------

      String userName = "Mahasiswa";
      String userEmail = email;

      if (user != null) {
        final prefs = await SharedPreferences.getInstance();

        // USER ID
        if (user["id"] != null) {
          await prefs.setInt(
            "user_id",
            user["id"],
          );
        }

        // NAMA
        userName = user["name"]?.toString().trim().isNotEmpty == true
            ? user["name"].toString()
            : "Mahasiswa";

        await prefs.setString(
          "user_name",
          userName,
        );

        // EMAIL
        userEmail = user["email"]?.toString().trim().isNotEmpty == true
            ? user["email"].toString()
            : email;

        await prefs.setString(
          "user_email",
          userEmail,
        );
      } else {
        // -----------------------------------------------------
        // FALLBACK JIKA OBJECT USER TIDAK DIKIRIM API
        // -----------------------------------------------------

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString(
          "user_name",
          userName,
        );

        await prefs.setString(
          "user_email",
          userEmail,
        );
      }

      if (!mounted) return;

      // -------------------------------------------------------
      // MASUK KE APLIKASI
      // -------------------------------------------------------

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BottomNav(
            userName: userName,
            userEmail: userEmail,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Terjadi kesalahan server",
          ),
        ),
      );
    }
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090B20),
      body: Stack(
        children: [

          // ===================================================
          // BACKGROUND
          // ===================================================

          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, -0.25),
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

          // ===================================================
          // PURPLE GLOW - TOP LEFT
          // ===================================================

          Positioned(
            top: 50,
            left: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF7C3AED)
                    .withValues(alpha: 0.10),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6)
                        .withValues(alpha: 0.22),
                    blurRadius: 110,
                    spreadRadius: 40,
                  ),
                ],
              ),
            ),
          ),

          // ===================================================
          // CYAN GLOW - BOTTOM RIGHT
          // ===================================================

          Positioned(
            bottom: 20,
            right: -100,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF5EDBD5)
                    .withValues(alpha: 0.06),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5EDBD5)
                        .withValues(alpha: 0.12),
                    blurRadius: 120,
                    spreadRadius: 40,
                  ),
                ],
              ),
            ),
          ),

          // ===================================================
          // CONTENT
          // ===================================================

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      // =========================================
                      // HEADER / LOGO
                      // =========================================

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 30,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white
                              .withValues(alpha: 0.045),
                          borderRadius:
                              BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0xFF8B7ACB)
                                .withValues(alpha: 0.35),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF7C3AED)
                                  .withValues(alpha: 0.12),
                              blurRadius: 30,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [

                            // =================================
                            // LOGO
                            // =================================

                            Container(
                              width: 125,
                              height: 125,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient:
                                    const LinearGradient(
                                  begin:
                                      Alignment.topLeft,
                                  end:
                                      Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFB65CFF),
                                    Color(0xFF7458FF),
                                    Color(0xFF5EDBD5),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF8B5CF6,
                                    ).withValues(
                                      alpha: 0.40,
                                    ),
                                    blurRadius: 30,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: Container(
                                margin:
                                    const EdgeInsets.all(5),
                                decoration:
                                    const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF101329),
                                ),
                                child: Stack(
                                  alignment:
                                      Alignment.center,
                                  children: [

                                    // BRAIN
                                    const Positioned(
                                      top: 15,
                                      child: Icon(
                                        Icons
                                            .psychology_rounded,
                                        size: 52,
                                        color:
                                            Color(0xFFB77AFF),
                                      ),
                                    ),

                                    // CHAT BUBBLE
                                    Positioned(
                                      bottom: 19,
                                      left: 13,
                                      child: Container(
                                        width: 63,
                                        height: 43,
                                        decoration:
                                            BoxDecoration(
                                          borderRadius:
                                              BorderRadius
                                                  .circular(
                                            15,
                                          ),
                                          gradient:
                                              const LinearGradient(
                                            colors: [
                                              Color(
                                                0xFF8B4DFF,
                                              ),
                                              Color(
                                                0xFF6155E8,
                                              ),
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  const Color(
                                                0xFF8B5CF6,
                                              ).withValues(
                                                alpha: 0.35,
                                              ),
                                              blurRadius: 12,
                                            ),
                                          ],
                                        ),
                                        child:
                                            const Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                            children: [
                                              _LoginDot(),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              _LoginDot(),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              _LoginDot(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    // FACE
                                    const Positioned(
                                      right: 12,
                                      bottom: 13,
                                      child: Icon(
                                        Icons.face_rounded,
                                        size: 63,
                                        color:
                                            Color(0xFF67DDD2),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 22),

                            // =================================
                            // MINDCARE TITLE
                            // =================================

                            const Text.rich(
                              TextSpan(
                                children: [

                                  TextSpan(
                                    text: "Mind",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight:
                                          FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: -0.8,
                                    ),
                                  ),

                                  TextSpan(
                                    text: "Care",
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight:
                                          FontWeight.w700,
                                      color:
                                          Color(0xFF9B78FF),
                                      letterSpacing: -0.8,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 6),

                            // =================================
                            // TAGLINE
                            // =================================

                            const Text(
                              "Teman Curhat Mahasiswa",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                    FontWeight.w400,
                                color: Colors.white70,
                                letterSpacing: 0.2,
                              ),
                            ),

                            const SizedBox(height: 18),

                            // =================================
                            // HEART DIVIDER
                            // =================================

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [

                                Container(
                                  width: 45,
                                  height: 1,
                                  decoration:
                                      BoxDecoration(
                                    gradient:
                                        LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        const Color(
                                          0xFFA855F7,
                                        ).withValues(
                                          alpha: 0.8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                const Icon(
                                  Icons.favorite_rounded,
                                  size: 17,
                                  color:
                                      Color(0xFFA855F7),
                                ),

                                const SizedBox(width: 10),

                                Container(
                                  width: 45,
                                  height: 1,
                                  decoration:
                                      BoxDecoration(
                                    gradient:
                                        LinearGradient(
                                      colors: [
                                        const Color(
                                          0xFFA855F7,
                                        ).withValues(
                                          alpha: 0.8,
                                        ),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // =========================================
                      // LOGIN TITLE
                      // =========================================

                      const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Selamat datang kembali di MindCare",
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 25),

                      // =========================================
                      // EMAIL
                      // =========================================

                      const Text(
                        "Email",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller: emailController,
                        keyboardType:
                            TextInputType.emailAddress,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              "Masukkan email kamu",
                          hintStyle:
                              const TextStyle(
                            color: Colors.white38,
                          ),
                          filled: true,
                          fillColor: Colors.white
                              .withValues(alpha: 0.055),
                          prefixIcon:
                              const Icon(
                            Icons.email_outlined,
                            color:
                                Color(0xFFB77AFF),
                          ),
                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(18),
                            borderSide:
                                BorderSide.none,
                          ),
                          enabledBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(18),
                            borderSide:
                                BorderSide(
                              color: Colors.white
                                  .withValues(
                                alpha: 0.06,
                              ),
                            ),
                          ),
                          focusedBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(18),
                            borderSide:
                                const BorderSide(
                              color:
                                  Color(0xFF9B78FF),
                              width: 1.2,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets
                                  .symmetric(
                            vertical: 18,
                            horizontal: 16,
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // =========================================
                      // PASSWORD
                      // =========================================

                      const Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 8),

                      TextField(
                        controller:
                            passwordController,
                        obscureText:
                            obscurePassword,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration:
                            InputDecoration(
                          hintText:
                              "Masukkan password",
                          hintStyle:
                              const TextStyle(
                            color: Colors.white38,
                          ),
                          filled: true,
                          fillColor: Colors.white
                              .withValues(alpha: 0.055),
                          prefixIcon:
                              const Icon(
                            Icons.lock_outline,
                            color:
                                Color(0xFFB77AFF),
                          ),
                          suffixIcon:
                              IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons
                                      .visibility_off
                                  : Icons.visibility,
                              color:
                                  Colors.white60,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePassword =
                                    !obscurePassword;
                              });
                            },
                          ),
                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(18),
                            borderSide:
                                BorderSide.none,
                          ),
                          enabledBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(18),
                            borderSide:
                                BorderSide(
                              color: Colors.white
                                  .withValues(
                                alpha: 0.06,
                              ),
                            ),
                          ),
                          focusedBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(18),
                            borderSide:
                                const BorderSide(
                              color:
                                  Color(0xFF9B78FF),
                              width: 1.2,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets
                                  .symmetric(
                            vertical: 18,
                            horizontal: 16,
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // =========================================
                      // LOGIN BUTTON
                      // =========================================

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed:
                              isLoading ? null : login,
                          style:
                              ElevatedButton.styleFrom(
                            elevation: 8,
                            shadowColor:
                                const Color(
                              0xFF7C3AED,
                            ).withValues(
                              alpha: 0.35,
                            ),
                            backgroundColor:
                                const Color(
                              0xFF7458FF,
                            ),
                            disabledBackgroundColor:
                                const Color(
                              0xFF7458FF,
                            ).withValues(
                              alpha: 0.5,
                            ),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                18,
                              ),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  width: 23,
                                  height: 23,
                                  child:
                                      CircularProgressIndicator(
                                    color:
                                        Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                  children: [

                                    Icon(
                                      Icons
                                          .login_rounded,
                                      color:
                                          Colors.white,
                                      size: 21,
                                    ),

                                    SizedBox(width: 10),

                                    Text(
                                      "Login",
                                      style:
                                          TextStyle(
                                        color:
                                            Colors.white,
                                        fontSize: 16,
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),

                      const SizedBox(height: 22),

                      // =========================================
                      // REGISTER
                      // =========================================

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [

                          const Text(
                            "Belum punya akun?",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 14,
                            ),
                          ),

                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              "Daftar",
                              style: TextStyle(
                                color:
                                    Color(0xFFB77AFF),
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
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

// =============================================================
// DOT CHAT BUBBLE
// =============================================================

class _LoginDot extends StatelessWidget {
  const _LoginDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }
}