import 'package:flutter/material.dart';
import '../api/tahlil_service.dart';
import 'content_helper.dart';

class Logo5Page extends StatefulWidget {
  const Logo5Page({super.key});

  @override
  State<Logo5Page> createState() => _Logo5PageState();
}

class _Logo5PageState extends State<Logo5Page> {
  bool loading = true;
  List<ContentItem> items = [];

  @override
  void initState() {
    super.initState();
    loadTahlil();
  }

  Future<void> loadTahlil() async {
    try {
      final list = await TahlilService.fetchTahlil();

      items = list.map((data) {
        return ContentItem(
          arabic: data["ar"] ?? "",
          latin: data["tr"] ?? "",
          translation: data["idn"] ?? "",
          number: data["id"]?.toString() ?? "",
        );
      }).toList();

      setState(() => loading = false);
    } catch (e) {
      debugPrint("Error: $e");
      setState(() => loading = false);
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
              title: 'Tahlil',
              subtitle: 'Bacaan Lengkap',
              icon: Icons.favorite,
              arabicTitle: 'تهليل',
              items: items,
            ),
          );
  }
}
