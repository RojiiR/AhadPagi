import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'content_helper.dart';

// =========================
// MODEL AYAT UNTUK EQURAN
// =========================
class Ayat {
  final int number;
  final String arabic;
  final String translation;

  Ayat({
    required this.number,
    required this.arabic,
    required this.translation,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      number: json['nomor'],
      arabic: json['ar'],
      translation: json['idn'], // API EQuran pakai 'idn'
    );
  }
}

// =========================
// SERVICE PENGAMBILAN DATA
// =========================
class QuranService {
  static Future<List<Ayat>> fetchYasin() async {
    final url = Uri.parse("https://equran.id/api/surat/36");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List ayatList = data["ayat"];

      return ayatList.map((e) => Ayat.fromJson(e)).toList();
    } else {
      throw Exception("Gagal memuat data");
    }
  }
}

// =========================
// PAGE SURAT YASIN
// =========================
class Logo1Page extends StatefulWidget {
  const Logo1Page({super.key});

  @override
  State<Logo1Page> createState() => _Logo1PageState();
}

class _Logo1PageState extends State<Logo1Page> {
  late Future<List<Ayat>> futureAyat;

  @override
  void initState() {
    super.initState();
    futureAyat = QuranService.fetchYasin();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ayat>>(
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
            title: 'Surat Yasin',
            subtitle: 'Hati Al-Qur\'an',
            icon: Icons.menu_book,
            arabicTitle: 'يس',
            items: ayatList.map((a) {
              return ContentItem(
                number: a.number.toString(),
                arabic: a.arabic,
                latin: "", // API tidak punya latin, jadi kosong
                translation: a.translation,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
