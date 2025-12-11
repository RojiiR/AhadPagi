import 'package:flutter/material.dart';
import 'content_helper.dart';
import '../api/istighotsah_service.dart';

class Logo4Page extends StatefulWidget {
  const Logo4Page({super.key});

  @override
  State<Logo4Page> createState() => _Logo4PageState();
}

class _Logo4PageState extends State<Logo4Page> {
  bool loading = true;
  List<ContentItem> items = [];

  @override
  void initState() {
    super.initState();
    loadIstighotsah();
  }

  Future<void> loadIstighotsah() async {
    try {
      final data = await IstighotsahService.fetchIstighotsah();

      final itemsList = (data["bacaan"] as List).map((e) {
        return ContentItem(
          number: "${e["id"]}",
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
      debugPrint("Error: $e");
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
              title: 'Istighotsah',
              subtitle: 'Memohon Pertolongan Allah',
              icon: Icons.pan_tool,
              arabicTitle: 'إستغاثة',
              items: items,
            ),
          );
  }
}
