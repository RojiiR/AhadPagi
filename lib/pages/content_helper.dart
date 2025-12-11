import 'package:flutter/material.dart';
import 'dart:async';

class ContentPageData {
  final String title;
  final String subtitle;
  final IconData icon;
  final String arabicTitle;
  final List<ContentItem> items;

  ContentPageData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.arabicTitle,
    required this.items,
  });
}

class ContentItem {
  final String? number;
  final String arabic;
  final String latin;
  final String translation;

  ContentItem({
    this.number,
    required this.arabic,
    required this.latin,
    required this.translation,
  });
}

class ContentPage extends StatefulWidget {
  final ContentPageData data;

  const ContentPage({super.key, required this.data});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

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
          _buildHeader(isDark),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00CED1),
                            height: 2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          widget.data.arabicTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00CED1),
                            height: 2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...widget.data.items
                            .map((item) => _buildContentCard(
                                  item.number,
                                  item.arabic,
                                  item.latin,
                                  item.translation,
                                  isDark,
                                ))
                            .toList(),
                      ],
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

  Widget _buildHeader(bool isDark) {
    return Container(
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
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                    child: Icon(
                      widget.data.icon,
                      size: 35,
                      color: const Color(0xFF00CED1),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.data.subtitle,
                          style: const TextStyle(
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
    );
  }

  Widget _buildContentCard(
    String? number,
    String arabic,
    String latin,
    String translation,
    bool isDark,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF00CED1).withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF00CED1).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (number != null)
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00CED1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      number,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if (number != null) const SizedBox(height: 12),
          Text(
            arabic,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00CED1),
              height: 2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            latin,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: isDark ? Colors.grey[400] : Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            translation,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.grey[300] : Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
