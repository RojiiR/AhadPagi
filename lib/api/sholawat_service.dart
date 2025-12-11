import 'dart:convert';
import 'package:http/http.dart' as http;

class SholawatService {
  static Future<List<dynamic>> fetchSholawat() async {
    final url = Uri.parse(
      "https://raw.githubusercontent.com/RojiiR/api-json-ahad-pagi-app/main/sholawat.json",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Kita ambil bagian "bacaan" yang berupa List
      return data["bacaan"] ?? [];
    } else {
      throw Exception("Failed to load Sholawat");
    }
  }
}
