import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/splash_screen.dart';
import 'pages/beranda_page.dart';
import 'pages/catatanku_page.dart';
import 'pages/kalender_page.dart';
import 'pages/akun_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('darkMode') ?? false;
  runApp(IslamicApp(isDarkMode: isDark));
}

class IslamicApp extends StatefulWidget {
  final bool isDarkMode;
  const IslamicApp({super.key, required this.isDarkMode});

  @override
  State<IslamicApp> createState() => _IslamicAppState();

  static _IslamicAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_IslamicAppState>();
}

class _IslamicAppState extends State<IslamicApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  void toggleTheme(bool isDark) async {
    setState(() {
      _isDarkMode = isDark;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Islamic App',
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        primaryColor: const Color(0xFF00CED1),
        scaffoldBackgroundColor: Colors.grey[50],
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00CED1),
          primary: const Color(0xFF00CED1),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        primaryColor: const Color(0xFF00CED1),
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00CED1),
          primary: const Color(0xFF00CED1),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const BerandaPage(),
    const CatatankuPage(),
    const KalenderPage(),
    const AkunPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          border: Border(
            top: BorderSide(color: const Color(0xFF00CED1), width: 2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: isDark ? const Color(0xFF2A2A2A) : Colors.white,
          selectedItemColor: const Color(0xFF00CED1),
          unselectedItemColor: isDark ? Colors.grey[400] : Colors.grey[600],
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Catatanku'),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Kalender',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
          ],
        ),
      ),
    );
  }
}
