// logo3_page.dart - Surat Al-Mulk
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'content_helper.dart';

// =========================
// MODEL AYAT AL-MULK
// =========================
class AyatMulk {
  final int number;
  final String arabic;
  final String translation;

  AyatMulk({
    required this.number,
    required this.arabic,
    required this.translation,
  });

  factory AyatMulk.fromJson(Map<String, dynamic> json) {
    return AyatMulk(
      number: json['nomor'],
      arabic: json['ar'],
      translation: json['idn'],
    );
  }
}

// =========================
// SERVICE API SURAT AL-MULK
// =========================
class QuranServiceMulk {
  static Future<List<AyatMulk>> fetchMulk() async {
    final url = Uri.parse("https://equran.id/api/surat/67");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List ayatList = data["ayat"];

      return ayatList.map((e) => AyatMulk.fromJson(e)).toList();
    } else {
      throw Exception("Gagal memuat Surat Al-Mulk");
    }
  }
}

// =========================
// HALAMAN SURAT AL-MULK
// =========================
class Logo3Page extends StatefulWidget {
  const Logo3Page({super.key});

  @override
  State<Logo3Page> createState() => _Logo3PageState();
}

class _Logo3PageState extends State<Logo3Page> {
  late Future<List<AyatMulk>> futureAyat;

  @override
  void initState() {
    super.initState();
    futureAyat = QuranServiceMulk.fetchMulk();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AyatMulk>>(
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
            title: 'Surat Al-Mulk',
            subtitle: 'Tabarokalladzi',
            icon: Icons.auto_stories,
            arabicTitle: 'الملك',
            items: ayatList.map((a) {
              return ContentItem(
                number: a.number.toString(),
                arabic: a.arabic,
                latin: "", // API tidak ada latin
                translation: a.translation,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
