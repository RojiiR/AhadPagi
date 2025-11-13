// screens/settings_screen.dart

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // Warna kustom yang konsisten
  static const Color primaryDarkColor = Color(0xFF222B35); // Background gelap
  static const Color accentLightColor = Color(
    0xFF8B929B,
  ); // Warna garis pemisah

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDarkColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Custom AppBar ---
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 15.0,
              ),
              child: Row(
                children: [
                  // Tombol Back
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      // Kembali ke Home Screen
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 40.0,
                        ), // Kompensasi ikon back
                        child: Text(
                          'PENGATURAN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Garis pemisah bawah AppBar
            const Divider(color: accentLightColor, height: 1),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // --- Kategori BAHASA ---
                    _buildSettingsCategory(context, 'BAHASA'),
                    _buildRadioSetting(
                      context,
                      'Transliterasi',
                      isSelected: true,
                      onTapped: () {},
                    ),
                    _buildRadioSetting(
                      context,
                      'Terjemahan Bahasa Indonesia',
                      isSelected: false,
                      onTapped: () {},
                    ),

                    const SizedBox(height: 30),

                    // --- Kategori TAMPILAN ---
                    _buildSettingsCategory(context, 'TAMPILAN'),
                    _buildRadioSetting(
                      context,
                      'Layar Tetap Menyala',
                      isSelected: true,
                      onTapped: () {},
                    ),
                    _buildRadioSetting(
                      context,
                      'Nomor Kalimat',
                      isSelected: false,
                      onTapped: () {},
                    ),

                    const SizedBox(height: 30),

                    // --- Kategori TENTANG APLIKASI ---
                    _buildSettingsCategory(context, 'TENTANG APLIKASI'),
                    _buildSimpleSetting(
                      context,
                      'Berikan Penilaian',
                      onPressed: () {
                        // TODO: Tambahkan fungsi ke Play Store/App Store
                      },
                    ),
                    _buildSimpleSetting(
                      context,
                      'Bagikan Aplikasi',
                      onPressed: () {
                        // TODO: Tambahkan fungsi berbagi
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Pembantu untuk Judul Kategori
  Widget _buildSettingsCategory(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const Divider(
          color: accentLightColor,
          height: 10,
          thickness: 1,
        ), // Garis di bawah judul
        const SizedBox(height: 10),
      ],
    );
  }

  // Widget Pembantu untuk Opsi dengan Radio Button (Contoh: Pilihan Bahasa)
  Widget _buildRadioSetting(
    BuildContext context,
    String title, {
    required bool isSelected,
    required VoidCallback onTapped,
  }) {
    return InkWell(
      onTap: onTapped,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white70, fontSize: 15),
              ),
            ),
            Radio<bool>(
              value: isSelected,
              groupValue:
                  true, // Gunakan logika groupValue/value yang sesuai di StatefulWidget
              onChanged: (bool? value) {
                onTapped();
              },
              activeColor: Colors.white, // Warna radio button saat aktif
              fillColor: WidgetStateProperty.resolveWith<Color>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.white; // Warna saat terpilih
                }
                return Colors.white70; // Warna saat tidak terpilih
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Pembantu untuk Opsi Aksi Sederhana (Contoh: Bagikan Aplikasi)
  Widget _buildSimpleSetting(
    BuildContext context,
    String title, {
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
