// screens/splash_screen.dart

import 'package:flutter/material.dart';
import 'dart:async'; // Diperlukan untuk Timer

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Pindah ke halaman login setelah 5 detik
    Timer(const Duration(seconds: 10), () {
      // Menggunakan pushReplacementNamed agar pengguna tidak bisa kembali ke splash screen
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Mengatur warna background sesuai screenshot (dark blue-grey)
      backgroundColor: const Color(0xFF222B35), // Contoh warna yang mirip
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Pusatkan secara vertikal
          children: <Widget>[
            // Spacer di atas logo untuk penempatan yang lebih baik
            const Spacer(),

            // Logo aplikasi
            Image.asset(
              'assets/images/logo.png', // Pastikan path ini benar
              width: 150, // Sesuaikan ukuran logo sesuai kebutuhan
              height: 150,
            ),

            const Spacer(), // Spacer di antara logo dan teks bawah
            // Teks "AHAD PAGI"
            const Text(
              'AHAD PAGI',
              style: TextStyle(
                color: Colors.white, // Warna teks putih
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5, // Memberikan sedikit jarak antar huruf
              ),
            ),
            const SizedBox(height: 8), // Jarak antara dua baris teks
            // Teks "An-Nur 3 Muroh Banyu"
            const Text(
              'An-Nur 3 Muroh Banyu',
              style: TextStyle(
                color: Colors.white70, // Warna teks sedikit lebih redup
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 50), // Padding di bagian bawah
          ],
        ),
      ),
    );
  }
}
