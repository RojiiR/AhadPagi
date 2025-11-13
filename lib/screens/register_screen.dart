// screens/register_screen.dart

import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  // Warna-warna kustom yang konsisten dengan LoginScreen
  static const Color primaryDarkColor = Color(0xFF222B35);
  static const Color accentDarkColor = Color(
    0xFF34404C,
  ); // Warna tombol Register

  @override
  Widget build(BuildContext context) {
    // Media query untuk mendapatkan tinggi layar
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        // Background Gradien Vertikal (Dark Grey ke Light Grey) - Sama seperti Login
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

        // SingleChildScrollView agar input bisa di-scroll
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Ruang kosong di bagian atas background
              SizedBox(height: screenHeight * 0.15),

              // Register Card
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
                    // Judul REGISTRATION
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Text(
                        'REGISTRATION',
                        style: TextStyle(
                          color: accentDarkColor,
                          fontSize: 26,
                          fontWeight: FontWeight.w900, // Sangat tebal
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),

                    // --- Input Full Name ---
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Full Name',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTextField(hintText: 'Masukkan nama lengkap Anda'),
                    const SizedBox(height: 20),

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
                      hintText: 'Buat password Anda',
                      isPassword: true,
                    ),
                    const SizedBox(
                      height: 40,
                    ), // Ruang lebih banyak di bawah field
                    // --- Tombol REGISTER ---
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Setelah register, navigasi kembali ke Login
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentDarkColor, // Warna gelap
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'REGISTER',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // --- Link Sign In (sudah punya akun) ---
                    const Text(
                      "if you have Account",
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigasi kembali ke Login
                        Navigator.pop(
                          context,
                        ); // Atau Navigator.pushNamed(context, '/login')
                      },
                      child: const Text(
                        'Sign In',
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
