import 'dart:convert';
import 'package:http/http.dart' as http;

class IstighotsahService {
  static Future<Map<String, dynamic>> fetchIstighotsah() async {
    final url = Uri.parse(
      "https://raw.githubusercontent.com/RojiiR/api-json-ahad-pagi-app/main/istighotsah.json",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data; // kembali MAP sesuai struktur JSON
    } else {
      throw Exception("Failed to load Istighotsah");
    }
  }
}
