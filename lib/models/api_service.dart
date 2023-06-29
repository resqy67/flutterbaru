import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String apiUrl = "https://masak-n47txy691-tomorisakura.vercel.app/";

  Future<List<Map<String, dynamic>>> fetchRecipes(int page) async {
    final response = await http.get(Uri.parse("$apiUrl/api/recipes/$page"));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['results'];
      return List<Map<String, dynamic>>.from(jsonData);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<List<Map<String, dynamic>>> fetchArtikel(int page) async {
    String apiUrl;

    if (page == 1) {
      apiUrl =
          "https://resep-hari-ini.vercel.app/api/category/article/tips-masak";
    } else if (page == 2) {
      apiUrl =
          "https://resep-hari-ini.vercel.app/api/category/article/makanan-gaya-hidup";
    } else if (page == 3) {
      apiUrl =
          "https://resep-hari-ini.vercel.app/api/category/article/resep-lezat-anti-sisa";
    } else if (page == 4) {
      apiUrl =
          "https://resep-hari-ini.vercel.app/api/category/article/uncategorized";
    } else {
      throw Exception('Invalid page number');
    }

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['results'];
      return List<Map<String, dynamic>>.from(jsonData);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  //buatkan future untuk fetch detail
  Future<Map<String, dynamic>> fetchRecipeDetail(String key) async {
    final response = await http.get(Uri.parse("$apiUrl/api/recipe/$key"));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Map<String, dynamic>.from(jsonData);
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
