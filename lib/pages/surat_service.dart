import 'dart:convert';
import 'package:http/http.dart' as http;

class SuratService {
  static Future<List<dynamic>> fetchSuratAlMulk() async {
    final url = Uri.parse("https://equran.id/api/v2/surat/67");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['data']['ayat'];
    } else {
      throw Exception("Gagal mengambil data Surat Al-Mulk");
    }
  }

  static Future<List<dynamic>> fetchDoaDzikir() async {
    final url = Uri.parse("https://equran.id/api/v2/doa");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['data'];
    } else {
      throw Exception("Gagal mengambil data Doa/Dzikir");
    }
  }
}
