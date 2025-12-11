import 'package:flutter/material.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'logo1_page.dart';
import 'logo2_page.dart';
import 'logo3_page.dart';
import 'logo4_page.dart';
import 'logo5_page.dart';
import 'logo6_page.dart';
import 'logo7_page.dart';
import 'logo8_page.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  // Daftar video YouTube dengan ID dan judul
  // Daftar video YouTube dengan ID dan judul
  final List<Map<String, String>> _youtubeVideos = [
    {
      'id': '_VrZCBlNJ3M',
      'title': 'Pengajian Rutin Ahad Pagi Online',
      'url': 'https://www.youtube.com/watch?v=_VrZCBlNJ3M&t=691s'
    },
    {
      'id': 'QgMU1txip3Q',
      'title': 'Murobbi Ruhina',
      'url': 'https://www.youtube.com/watch?v=QgMU1txip3Q&t=19s'
    },
    {
      'id': '3TTwMO1H9ng',
      'title': 'Sang Murobbi',
      'url':
          'https://www.youtube.com/watch?v=3TTwMO1H9ng&t=21s&pp=0gcJCSMKAYcqIYzv'
    },
    {
      'id': 'B9n3_SntsT4',
      'title': 'Hari Santri Annur 3',
      'url': 'https://www.youtube.com/watch?v=B9n3_SntsT4&pp=0gcJCSMKAYcqIYzv'
    },
    {
      'id': '4h_jRAthU1Y',
      'title': 'Ahad Pagi 2018',
      'url': 'https://www.youtube.com/watch?v=4h_jRAthU1Y&pp=0gcJCSMKAYcqIYzv'
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

  String _getYouTubeThumbnail(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/mqdefault.jpg';
  }

  Future<void> _openYouTube(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tidak dapat membuka video'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(isDark),
            _buildPrayerTimesCard(isDark),
            _buildMenuIcons(isDark),
            _buildVideoSection(isDark),
            const SizedBox(height: 20),
          ],
        ),
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
                      Icons.person,
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
                          'Assalamu\'alaikum',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Zii',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
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

  Widget _buildPrayerTimesCard(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF00CED1), width: 2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00CED1).withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.access_time,
                  color: Color(0xFF00CED1),
                  size: 22,
                ),
                SizedBox(width: 8),
                Text(
                  'Jadwal Sholat',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00CED1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPrayerTime('Subuh', '04:45', isDark),
                _buildPrayerTime('Dzuhur', '12:05', isDark),
                _buildPrayerTime('Ashar', '15:20', isDark),
                _buildPrayerTime('Maghrib', '18:15', isDark),
                _buildPrayerTime('Isya', '19:30', isDark),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerTime(String name, String time, bool isDark) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00CED1),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: TextStyle(
            fontSize: 11,
            color: isDark ? Colors.grey[300] : Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuIcons(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        mainAxisSpacing: 15,
        childAspectRatio: 0.75,
        crossAxisSpacing: 15,
        children: [
          _buildMenuItem(
              context, 'Yassin', Icons.book, const Logo1Page(), isDark),
          _buildMenuItem(
              context, 'Waqi\'ah', Icons.book, const Logo2Page(), isDark),

          // Tahlil → Al-Mulk
          _buildMenuItem(context, 'Al-Mulk', Icons.auto_stories,
              const Logo3Page(), isDark),

          _buildMenuItem(
              context, 'Istighosah', Icons.pan_tool, const Logo4Page(), isDark),

          // Burdah → Tahlil
          _buildMenuItem(
              context, 'Tahlil', Icons.favorite, const Logo5Page(), isDark),

          // Diba' → Sholawat
          _buildMenuItem(
              context, 'Sholawat', Icons.star, const Logo6Page(), isDark),

          // Sholawat → Doa-Doa
          _buildMenuItem(
              context, 'Doa Doa', Icons.wb_sunny, const Logo7Page(), isDark),

          _buildMenuItem(
              context, 'Lainnya', Icons.more_horiz, const Logo8Page(), isDark),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon,
      Widget page, bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: const Color(0xFF00CED1).withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF00CED1), width: 2),
            ),
            child: Icon(
              icon,
              size: 30,
              color: const Color(0xFF00CED1),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.grey[300] : Colors.grey[800],
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildVideoSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Video Menarik untuk Anda',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00CED1),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final Uri uri = Uri.parse('https://www.youtube.com');
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
                child: const Row(
                  children: [
                    Text(
                      'Lihat semua',
                      style: TextStyle(
                        color: Color(0xFF00CED1),
                        fontSize: 10,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Color(0xFF00CED1),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _youtubeVideos.length,
              itemBuilder: (context, index) {
                return _buildVideoCard(
                  _youtubeVideos[index]['title']!,
                  _youtubeVideos[index]['id']!,
                  _youtubeVideos[index]['url']!,
                  isDark,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(
      String title, String videoId, String url, bool isDark) {
    return GestureDetector(
      onTap: () => _openYouTube(url),
      child: Container(
        width: 250,
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00CED1).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      _getYouTubeThumbnail(videoId),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF00CED1), Color(0xFF00B4B8)],
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.play_circle_outline,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                    Center(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey[300] : Colors.grey[800],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
