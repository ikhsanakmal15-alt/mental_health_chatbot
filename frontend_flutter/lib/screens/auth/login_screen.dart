import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../navigation/bottom_nav.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  final TextEditingController
      emailController =
      TextEditingController();

  final TextEditingController
      passwordController =
      TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    final email =
        emailController.text.trim();

    final password =
        passwordController.text.trim();

    if (email.isEmpty ||
        password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Email dan password wajib diisi",
          ),
        ),
      );
      return;
    }

    String userName =
        email.split("@").first;

    userName =
        userName[0].toUpperCase() +
            userName.substring(1);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => BottomNav(
          userName: userName,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ================= HEADER =================
            Container(
              height: 320,
              width: double.infinity,

              decoration:
                  const BoxDecoration(
                gradient: LinearGradient(
                  begin:
                      Alignment.topLeft,
                  end: Alignment
                      .bottomRight,
                  colors: [
                    AppColors.primary,
                    AppColors.secondary,
                  ],
                ),
                borderRadius:
                    BorderRadius.only(
                  bottomLeft:
                      Radius.circular(40),
                  bottomRight:
                      Radius.circular(40),
                ),
              ),

              child: const Column(
                mainAxisAlignment:
                    MainAxisAlignment
                        .center,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor:
                        Colors.white24,
                    child: Icon(
                      Icons
                          .psychology_alt_rounded,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 20),

                  Text(
                    "MindCare",
                    style: TextStyle(
                      color:
                          Colors.white,
                      fontSize: 30,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Teman Curhat Mahasiswa",
                    style: TextStyle(
                      color:
                          Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            /// ================= FORM =================
            Padding(
              padding:
                  const EdgeInsets.all(
                      24),

              child: Column(
                children: [
                  const Align(
                    alignment:
                        Alignment
                            .centerLeft,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 8),

                  const Align(
                    alignment:
                        Alignment
                            .centerLeft,
                    child: Text(
                      "Mulai berbagi cerita 🌿",
                      style: TextStyle(
                        color:
                            Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 25),

                  /// EMAIL
                  TextField(
                    controller:
                        emailController,
                    keyboardType:
                        TextInputType
                            .emailAddress,

                    decoration:
                        InputDecoration(
                      hintText:
                          "Email Mahasiswa",

                      prefixIcon:
                          const Icon(
                        Icons
                            .email_outlined,
                      ),

                      filled: true,
                      fillColor:
                          Colors.white,

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                                    16),
                        borderSide:
                            BorderSide
                                .none,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 16),

                  /// PASSWORD
                  TextField(
                    controller:
                        passwordController,
                    obscureText:
                        obscurePassword,

                    decoration:
                        InputDecoration(
                      hintText:
                          "Password",

                      prefixIcon:
                          const Icon(
                        Icons
                            .lock_outline,
                      ),

                      suffixIcon:
                          IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons
                                  .visibility_off
                              : Icons
                                  .visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword =
                                !obscurePassword;
                          });
                        },
                      ),

                      filled: true,
                      fillColor:
                          Colors.white,

                      border:
                          OutlineInputBorder(
                        borderRadius:
                            BorderRadius
                                .circular(
                                    16),
                        borderSide:
                            BorderSide
                                .none,
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 25),

                  /// LOGIN BUTTON
                  SizedBox(
                    width:
                        double.infinity,
                    height: 55,

                    child:
                        ElevatedButton(
                      onPressed: login,

                      style:
                          ElevatedButton
                              .styleFrom(
                        backgroundColor:
                            AppColors
                                .primary,

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                                  16),
                        ),
                      ),

                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color:
                              Colors.white,
                          fontSize: 16,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 25),

                  /// MOTIVASI
                  Container(
                    padding:
                        const EdgeInsets
                            .all(16),

                    decoration:
                        BoxDecoration(
                      color:
                          const Color(
                              0xFFEAF8F0),

                      borderRadius:
                          BorderRadius
                              .circular(
                                  20),
                    ),

                    child: const Column(
                      children: [
                        Icon(
                          Icons.favorite,
                          color:
                              AppColors
                                  .primary,
                          size: 30,
                        ),

                        SizedBox(
                            height: 10),

                        Text(
                          "Setiap langkah kecil menuju kesehatan mental yang lebih baik adalah pencapaian besar 💚",
                          textAlign:
                              TextAlign
                                  .center,
                          style:
                              TextStyle(
                            height:
                                1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                      height: 20),

                  /// REGISTER
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                    children: [
                      const Text(
                        "Belum punya akun?",
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
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
                                AppColors
                                    .primary,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}