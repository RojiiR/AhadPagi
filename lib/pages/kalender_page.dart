import 'package:flutter/material.dart';
import 'dart:async';

class KalenderPage extends StatefulWidget {
  const KalenderPage({super.key});

  @override
  State<KalenderPage> createState() => _KalenderPageState();
}

class _KalenderPageState extends State<KalenderPage> {
  DateTime _selectedDate = DateTime.now();
  late int _daysInMonth;
  late int _firstDayOfMonth;
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _updateCalendar();
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

  void _updateCalendar() {
    _daysInMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;
    _firstDayOfMonth =
        DateTime(_selectedDate.year, _selectedDate.month, 1).weekday;
  }

  void _changeMonth(int delta) {
    setState(() {
      _selectedDate =
          DateTime(_selectedDate.year, _selectedDate.month + delta, 1);
      _updateCalendar();
    });
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

  String _getHijriDate() {
    return '27 Sya\'ban 1446 H';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.grey[50],
      body: Column(
        children: [
          // Header (sama seperti Beranda)
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
                            Icons.calendar_today,
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
                                'Kalender',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Pantau tanggal penting Islammu',
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

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Calendar Card
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: const Color(0xFF00CED1), width: 2),
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
                      children: [
                        // Month/Year Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => _changeMonth(-1),
                              icon: const Icon(Icons.chevron_left),
                              color: const Color(0xFF00CED1),
                            ),
                            Column(
                              children: [
                                Text(
                                  '${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00CED1),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _getHijriDate(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isDark
                                        ? Colors.grey[400]
                                        : Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () => _changeMonth(1),
                              icon: const Icon(Icons.chevron_right),
                              color: const Color(0xFF00CED1),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Day Names
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text('Min',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00CED1))),
                            Text('Sen',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00CED1))),
                            Text('Sel',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00CED1))),
                            Text('Rab',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00CED1))),
                            Text('Kam',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00CED1))),
                            Text('Jum',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00CED1))),
                            Text('Sab',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00CED1))),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Calendar Grid
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            childAspectRatio: 1,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: 42,
                          itemBuilder: (context, index) {
                            int day = index - _firstDayOfMonth + 2;
                            bool isCurrentMonth =
                                day > 0 && day <= _daysInMonth;
                            bool isToday = isCurrentMonth &&
                                day == DateTime.now().day &&
                                _selectedDate.month == DateTime.now().month &&
                                _selectedDate.year == DateTime.now().year;

                            return Container(
                              decoration: BoxDecoration(
                                color: isToday
                                    ? const Color(0xFF00CED1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  isCurrentMonth ? day.toString() : '',
                                  style: TextStyle(
                                    color: isToday
                                        ? Colors.white
                                        : isCurrentMonth
                                            ? (isDark
                                                ? Colors.grey[300]
                                                : Colors.grey[800])
                                            : Colors.grey[300],
                                    fontWeight: isToday
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Important Dates
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: const Color(0xFF00CED1), width: 2),
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
                          'Tanggal Penting',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00CED1),
                          ),
                        ),
                        const SizedBox(height: 15),
                        _buildImportantDate(
                            'Ramadhan 1446 H', '1 Maret 2025', isDark),
                        _buildImportantDate(
                            'Nuzulul Quran', '17 Maret 2025', isDark),
                        _buildImportantDate(
                            'Idul Fitri 1446 H', '31 Maret 2025', isDark),
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

  Widget _buildImportantDate(String title, String date, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF00CED1).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF00CED1),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.grey[300] : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey[500] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
