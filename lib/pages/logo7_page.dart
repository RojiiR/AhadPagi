import 'package:flutter/material.dart';
import 'content_helper.dart';
import '../api/doa_service.dart';

class Logo7Page extends StatefulWidget {
  const Logo7Page({super.key});

  @override
  State<Logo7Page> createState() => _Logo7PageState();
}

class _Logo7PageState extends State<Logo7Page> {
  bool loading = true;
  List<ContentItem> items = [];

  @override
  void initState() {
    super.initState();
    loadDoa();
  }

  Future<void> loadDoa() async {
    try {
      final data = await DoaService.fetchDoa();

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
      debugPrint("Error Doa: $e");
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
              title: 'Doa-Doa',
              subtitle: 'Kumpulan Doa Harian',
              icon: Icons.wb_sunny,
              arabicTitle: 'دعاء',
              items: items,
            ),
          );
  }
}
