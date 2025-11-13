import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color primaryDarkColor = Color(0xFF222B35); // Background gelap

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDarkColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Judul di Kiri Atas
              const Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 60.0),
                child: Text(
                  'AHAD PAGI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Tombol Utama
              _buildPillButton(
                text: 'YASIN & TAHLIL',
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
              ),
              const SizedBox(height: 25),
              _buildPillButton(text: 'LOREM IPSUM', onPressed: () {}),
              const SizedBox(height: 25),
              _buildPillButton(text: 'LOREM IPSUM', onPressed: () {}),
              const SizedBox(height: 25),
              _buildPillButton(text: 'LOREM IPSUM', onPressed: () {}),

              const Spacer(),

              // 3 Tombol di Bawah
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                child: Center(
                  child: SizedBox(
                    width:
                        200, // atur lebar baris biar ikon kiri-kanan agak dekat
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Exit
                        _buildIcon(
                          assetName: 'assets/images/exit.png',
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                        ),

                        // Profile
                        _buildIcon(
                          assetName: 'assets/images/profile.png',
                          onPressed: () {},
                        ),

                        // Settings
                        _buildIcon(
                          assetName: 'assets/images/setting.png',
                          onPressed: () {
                            Navigator.pushNamed(context, '/settings');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Tombol Utama (Pill)
  Widget _buildPillButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: primaryDarkColor,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  // Ikon Bawah
  Widget _buildIcon({
    required String assetName,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Padding(
        padding: const EdgeInsets.all(4.0), // jarak lebih kecil agar rapi
        child: Image.asset(
          assetName,
          width: 35, // sedikit lebih besar
          height: 35,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
