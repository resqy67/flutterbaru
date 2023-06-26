import 'dart:convert';
// import 'package:flutter12/models/resepList.dart';
// import 'package:http/http.dart' as http;

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://resep-hari-ini.vercel.app';

  Future<String> getResepHarian() async {
    final response = await http.get(Uri.parse('$baseUrl/api/recipes'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to fetch recipe');
    }
  }

  static getRecipes() {}
}


// class RecipeApi {
//   static Future<List<ResepList>> getRecipe() async {
//     var uri = Uri.https('resep-hari-ini.vercel.app', '/api/recipes', {
//       "limit": "10",
//       "start": "0",
//     });

//     final response = await http.get(uri, headers: {
//       // "x-rapidapi-key": "YOUR API KEY FROM YUMMLY API",
//       "x-rapidapi-host": "resep-hari-ini.vercel.app",
//       "useQueryString": "true"
//     });

//     Map data = jsonDecode(response.body);
//     List _temp = [];

//     for (var i in data['feed']) {
//       _temp.add(i['content']['details']);
//     }

//     return ResepList.recipesFromSnapshot(_temp);
//   }
// }
