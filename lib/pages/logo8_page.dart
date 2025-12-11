import 'package:flutter/material.dart';
import 'dart:async';
import 'logo1_page.dart';
import 'logo2_page.dart';
import 'logo3_page.dart';
import 'logo4_page.dart';
import 'logo5_page.dart';
import 'logo6_page.dart';
import 'logo7_page.dart';

class Logo8Page extends StatefulWidget {
  const Logo8Page({super.key});

  @override
  State<Logo8Page> createState() => _Logo8PageState();
}

class _Logo8PageState extends State<Logo8Page> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  final List<Map<String, dynamic>> _menus = [
    {
      'title': 'Surat Yassin',
      'subtitle': 'Hati Al-Qur\'an',
      'icon': Icons.book,
      'color': const Color(0xFF00CED1),
      'page': const Logo1Page(),
    },
    {
      'title': 'Surat Al-Waqi\'ah',
      'subtitle': 'Surat Kekayaan',
      'icon': Icons.book,
      'color': const Color(0xFF00B4B8),
      'page': const Logo2Page(),
    },
    {
      'title': 'Tahlil',
      'subtitle': 'Surat Al-Ikhlas',
      'icon': Icons.auto_stories,
      'color': const Color(0xFF00A5A8),
      'page': const Logo3Page(),
    },
    {
      'title': 'Istighotsah',
      'subtitle': 'Memohon Pertolongan',
      'icon': Icons.pan_tool,
      'color': const Color(0xFF009698),
      'page': const Logo4Page(),
    },
    {
      'title': 'Sholawat Burdah',
      'subtitle': 'Qasidah Al-Burdah',
      'icon': Icons.favorite,
      'color': const Color(0xFF008788),
      'page': const Logo5Page(),
    },
    {
      'title': 'Sholawat Diba\'',
      'subtitle': 'Maulid Diba\'iyyah',
      'icon': Icons.star,
      'color': const Color(0xFF007878),
      'page': const Logo6Page(),
    },
    {
      'title': 'Sholawat Jibril',
      'subtitle': 'Sholawat Malaikat',
      'icon': Icons.wb_sunny,
      'color': const Color(0xFF006968),
      'page': const Logo7Page(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _getGreeting() {
    final hour = _currentTime.hour;
    final dayName = _getDayName(_currentTime.weekday);

    if (hour < 12) return '$dayName Pagi';
    if (hour < 15) return '$dayName Siang';
    if (hour < 18) return '$dayName Sore';
    return '$dayName Malam';
  }

  String _getDayName(int weekday) {
    const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Ahad'];
    return days[weekday - 1];
  }

  String _getHijriDate() {
    return '27 Sya\'ban 1446 H';
  }

  String _getMonthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months[month - 1];
  }

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.more_horiz,
                            size: 35,
                            color: Color(0xFF00CED1),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Menu Lainnya',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Bacaan & Amalan Harian',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 1,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      _getGreeting(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${_currentTime.day} ${_getMonthName(_currentTime.month)} ${_currentTime.year}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      _getHijriDate(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content - List of Menus
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _menus.length,
              itemBuilder: (context, index) {
                return _buildMenuCard(
                  _menus[index]['title'],
                  _menus[index]['subtitle'],
                  _menus[index]['icon'],
                  _menus[index]['color'],
                  _menus[index]['page'],
                  isDark,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    Widget page,
    bool isDark,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: color,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 30,
                    color: color,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.grey[300] : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.grey[500] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: color,
                  size: 28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
