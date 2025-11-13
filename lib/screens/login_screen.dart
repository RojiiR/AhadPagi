// screens/login_screen.dart

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Warna-warna kustom berdasarkan screenshot
  static const Color primaryDarkColor = Color(
    0xFF222B35,
  ); // Mirip background Splash
  static const Color accentDarkColor = Color(0xFF34404C); // Warna tombol Log In

  @override
  Widget build(BuildContext context) {
    // Media query untuk mendapatkan tinggi layar
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        // Background Gradien Vertikal (Dark Grey ke Light Grey)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryDarkColor, // Darker color at the top
              Color(0xFF8B929B), // Lighter grey color at the bottom
            ],
          ),
        ),

        // SingleChildScrollView agar input bisa di-scroll saat keyboard muncul
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Ruang kosong di bagian atas background
              SizedBox(height: screenHeight * 0.15),

              // Login Card
              Container(
                width: double.infinity,
                // Mengatur tinggi card agar menyesuaikan konten
                constraints: BoxConstraints(minHeight: screenHeight * 0.85),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Logo "Ahad Pagi"
                    Image.asset(
                      'assets/images/logo2.png', // Pastikan path ini benar
                      width: 120,
                      height: 120,
                    ),
                    const SizedBox(height: 30),

                    // --- Input Email Address ---
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Email Address',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(hintText: 'Masukkan email Anda'),
                    const SizedBox(height: 20),

                    // --- Input Password ---
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Password',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(
                      hintText: 'Masukkan password Anda',
                      isPassword: true,
                    ),

                    // Tombol Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Tambahkan logika Forgot Password
                          print('Forgot Password ditekan!');
                        },
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- Tombol Log In ---
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigasi ke Tampilan Awal (Home Screen)
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentDarkColor, // Warna gelap
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // --- Link Sign Up ---
                    const Text(
                      "if you don't have Account",
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigasi ke Tampilan Register
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget Pembantu untuk Input Field yang konsisten
  Widget _buildTextField({required String hintText, bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          border: InputBorder.none, // Hapus border default
        ),
      ),
    );
  }
}
