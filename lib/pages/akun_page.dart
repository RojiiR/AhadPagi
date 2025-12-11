import 'package:flutter/material.dart';
import '../main.dart';

class AkunPage extends StatefulWidget {
  const AkunPage({super.key});

  @override
  State<AkunPage> createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  bool _notificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.grey[50],
      body: Column(
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF00CED1), Color(0xFF00B4B8)],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00CED1).withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Color(0xFF00CED1),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Zii',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'zii@email.com',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Profile Menu
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF00CED1),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00CED1).withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildMenuItem(
                          icon: Icons.person_outline,
                          title: 'Edit Profil',
                          onTap: () {},
                          isDark: isDark,
                        ),
                        _buildDivider(isDark),
                        _buildMenuItem(
                          icon: Icons.notifications_outlined,
                          title: 'Pengaturan Notifikasi',
                          onTap: () {},
                          isDark: isDark,
                        ),
                        _buildDivider(isDark),
                        _buildMenuItem(
                          icon: Icons.info_outline,
                          title: 'Tentang Aplikasi',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: isDark
                                    ? const Color(0xFF2A2A2A)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: const Text(
                                  'Tentang Aplikasi',
                                  style: TextStyle(
                                    color: Color(0xFF00CED1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Text(
                                  'Islamic App\nVersi 1.0.0\n\nAplikasi untuk membantu ibadah harian Anda.',
                                  style: TextStyle(
                                    height: 1.5,
                                    color: isDark
                                        ? Colors.grey[300]
                                        : Colors.black87,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text(
                                      'Tutup',
                                      style: TextStyle(
                                        color: Color(0xFF00CED1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Settings
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF00CED1),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00CED1).withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Pengaturan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00CED1),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildSwitchTile(
                          title: 'Mode Gelap',
                          value: isDark,
                          onChanged: (value) {
                            IslamicApp.of(context)?.toggleTheme(value);
                          },
                          isDark: isDark,
                        ),
                        const SizedBox(height: 15),
                        _buildSwitchTile(
                          title: 'Notifikasi Sholat',
                          value: _notificationEnabled,
                          onChanged: (value) {
                            setState(() {
                              _notificationEnabled = value;
                            });
                          },
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor:
                                isDark ? const Color(0xFF2A2A2A) : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Text(
                              'Keluar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color:
                                    isDark ? Colors.grey[300] : Colors.black87,
                              ),
                            ),
                            content: Text(
                              'Apakah Anda yakin ingin keluar?',
                              style: TextStyle(
                                color:
                                    isDark ? Colors.grey[400] : Colors.black87,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Batal',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  // Add logout logic here
                                },
                                child: const Text(
                                  'Keluar',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                      ),
                      child: const Text(
                        'Keluar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF00CED1), size: 24),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.grey[300] : Colors.black87,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isDark ? Colors.grey[500] : Colors.grey,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(bool isDark) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      color: isDark ? Colors.grey[700] : Colors.grey[200],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isDark,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.grey[300] : Colors.black87,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF00CED1),
        ),
      ],
    );
  }
}
