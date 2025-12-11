import 'dart:convert';
import 'package:http/http.dart' as http;

class TahlilService {
  static Future<List<Map<String, dynamic>>> fetchTahlil() async {
    final url = Uri.parse(
        "https://raw.githubusercontent.com/RojiiR/api-json-ahad-pagi-app/main/tahlil.json");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonData["bacaan"]);
    } else {
      throw Exception("Gagal memuat data tahlil");
    }
  }
}
