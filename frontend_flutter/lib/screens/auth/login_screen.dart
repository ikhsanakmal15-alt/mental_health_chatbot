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

  /// ================= LOGIN =================
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email dan password wajib diisi")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final result = await AuthService.login(email, password);

      setState(() => isLoading = false);

      if (!mounted) return;

      /// ❌ LOGIN GAGAL
      if (result == null || result["access_token"] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login gagal: email atau password salah")),
        );
        return;
      }

      /// ✅ LOGIN BERHASIL
      final user = result["user"];

      if (user != null) {

        final prefs = await SharedPreferences.getInstance();

        await prefs.setInt(
          "user_id",
          user["id"],
        );

        await prefs.setString(
          "user_name",
          user["name"] ?? "User",
        );
      }


      final userName = user != null
          ? user["name"] ?? "User"
          : "User";


      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BottomNav(userName: userName),
        ),
      );
    } catch (e) {
      setState(() => isLoading = false);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan server")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Stack(
        children: [

          /// ================= BACKGROUND =================
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color(0xFF2A1B4D),
                  Color(0xFF0B0B12),
                ],
                radius: 1.2,
              ),
            ),
          ),

          /// ================= CONTENT =================
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    /// ================= HEADER =================
                    Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Column(
                        children: const [
                          Icon(
                            Icons.psychology_alt_rounded,
                            color: Colors.white,
                            size: 50,
                          ),
                          SizedBox(height: 15),
                          Text(
                            "MindCare",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Teman Curhat Mahasiswa",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// ================= EMAIL =================
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: AppColors.surface,
                        prefixIcon: const Icon(Icons.email_outlined,
                            color: Colors.white70),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    /// ================= PASSWORD =================
                    TextField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: AppColors.surface,
                        prefixIcon: const Icon(Icons.lock_outline,
                            color: Colors.white70),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// ================= LOGIN BUTTON =================
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// ================= REGISTER =================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Belum punya akun?",
                          style: TextStyle(color: Colors.white60),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Daftar",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}