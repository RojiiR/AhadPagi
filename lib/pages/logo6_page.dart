import 'package:flutter/material.dart';
import 'content_helper.dart';
import '../api/sholawat_service.dart';

class Logo6Page extends StatefulWidget {
  const Logo6Page({super.key});

  @override
  State<Logo6Page> createState() => _Logo6PageState();
}

class _Logo6PageState extends State<Logo6Page> {
  bool loading = true;
  List<ContentItem> items = [];

  @override
  void initState() {
    super.initState();
    loadSholawat();
  }

  Future<void> loadSholawat() async {
    try {
      final data = await SholawatService.fetchSholawat();

      final itemsList = data.map((e) {
        return ContentItem(
          number: e["id"].toString(),
          arabic: e["ar"] ?? "",
          latin: e["tr"] ?? "",
          translation: e["idn"] ?? "",
        );
      }).toList();

      setState(() {
        items = itemsList;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      debugPrint("Error Sholawat: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : ContentPage(
            data: ContentPageData(
              title: 'Sholawat Diba\'',
              subtitle: 'Maulid Diba\'iyyah',
              icon: Icons.star,
              arabicTitle: 'مولد الديباعي',
              items: items,
            ),
          );
  }
}
