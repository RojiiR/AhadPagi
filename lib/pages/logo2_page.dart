import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'content_helper.dart';

// =========================
// MODEL AYAT EQURAN
// =========================
class AyatWaqiah {
  final int number;
  final String arabic;
  final String translation;

  AyatWaqiah({
    required this.number,
    required this.arabic,
    required this.translation,
  });

  factory AyatWaqiah.fromJson(Map<String, dynamic> json) {
    return AyatWaqiah(
      number: json['nomor'],
      arabic: json['ar'],
      translation: json['idn'],
    );
  }
}

// =========================
// SERVICE API SURAT WAQI'AH
// =========================
class QuranServiceWaqiah {
  static Future<List<AyatWaqiah>> fetchWaqiah() async {
    final url = Uri.parse("https://equran.id/api/surat/56");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List ayatList = data["ayat"];

      return ayatList.map((e) => AyatWaqiah.fromJson(e)).toList();
    } else {
      throw Exception("Gagal memuat Surat Al-Waqi'ah");
    }
  }
}

// =========================
// PAGE SURAT AL-WAQI'AH
// =========================
class Logo2Page extends StatefulWidget {
  const Logo2Page({super.key});

  @override
  State<Logo2Page> createState() => _Logo2PageState();
}

class _Logo2PageState extends State<Logo2Page> {
  late Future<List<AyatWaqiah>> futureAyat;

  @override
  void initState() {
    super.initState();
    futureAyat = QuranServiceWaqiah.fetchWaqiah();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AyatWaqiah>>(
      future: futureAyat,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Gagal memuat data: ${snapshot.error}"),
            ),
          );
        }

        final ayatList = snapshot.data!;

        return ContentPage(
          data: ContentPageData(
            title: 'Surat Al-Waqi\'ah',
            subtitle: 'Surat Kekayaan',
            icon: Icons.menu_book,
            arabicTitle: 'الواقعة',
            items: ayatList.map((a) {
              return ContentItem(
                number: a.number.toString(),
                arabic: a.arabic,
                latin: "", // API tidak punya latin
                translation: a.translation,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
