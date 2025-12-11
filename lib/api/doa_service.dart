import 'dart:convert';
import 'package:http/http.dart' as http;

class DoaService {
  static Future<List<dynamic>> fetchDoa() async {
    final url = Uri.parse(
      "https://raw.githubusercontent.com/RojiiR/api-json-ahad-pagi-app/main/doa.json",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      return data["bacaan"] ?? [];
    } else {
      throw Exception("Failed to load Doa");
    }
  }
}
