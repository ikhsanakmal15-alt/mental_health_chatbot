import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ================= HEADER =================
            Container(
              height: 280,
              width: double.infinity,

              decoration: const BoxDecoration(
                gradient: LinearGradient(
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

              child: SafeArea(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: const [
                    Icon(
                      Icons.person_add_alt_1,
                      color: Colors.white,
                      size: 80,
                    ),

                    SizedBox(height: 15),

                    Text(
                      "Buat Akun Baru 🌿",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      "Mulai perjalanan kesehatan mentalmu bersama MindCare",
                      textAlign:
                          TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// ================= FORM =================
            Padding(
              padding:
                  const EdgeInsets.all(24),

              child: Column(
                children: [
                  /// NAMA
                  TextField(
                    controller:
                        nameController,

                    decoration:
                        InputDecoration(
                      hintText:
                          "Nama Lengkap",

                      prefixIcon:
                          const Icon(
                        Icons.person_outline,
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

                  const SizedBox(height: 16),

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
                        Icons.email_outlined,
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

                  const SizedBox(height: 16),

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
                        Icons.lock_outline,
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

                  const SizedBox(height: 25),

                  /// BUTTON REGISTER
                  SizedBox(
                    width:
                        double.infinity,
                    height: 55,

                    child:
                        ElevatedButton(
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

                      onPressed: () {
                        ScaffoldMessenger.of(
                                context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Registrasi berhasil 🎉",
                            ),
                          ),
                        );

                        Navigator.pop(
                            context);
                      },

                      child: const Text(
                        "Daftar Sekarang",
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

                  const SizedBox(height: 25),

                  /// MOTIVASI
                  Container(
                    padding:
                        const EdgeInsets.all(
                            16),

                    decoration:
                        BoxDecoration(
                      color: const Color(
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
                        ),

                        SizedBox(height: 10),

                        Text(
                          "Perjalanan menuju kesehatan mental yang lebih baik dimulai dari langkah kecil hari ini 💚",
                          textAlign:
                              TextAlign
                                  .center,
                          style:
                              TextStyle(
                            fontSize:
                                14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// LOGIN
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                    children: [
                      const Text(
                        "Sudah punya akun?",
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                              context);
                        },
                        child: const Text(
                          "Login",
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