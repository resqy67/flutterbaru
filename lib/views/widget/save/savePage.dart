import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:maskara/models/model.dart';
import 'package:maskara/views/widget/Resep/resepPage_Detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavePage extends StatefulWidget {
  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  List<String> savedRecipes = [];

  @override
  void initState() {
    super.initState();
    _getSavedRecipes();
  }

  Future<void> _getSavedRecipes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedRecipes = prefs.getStringList('savedRecipes') ?? [];
    });
  }

  Future<Recipe> fetchRecipe(String key) async {
    final response = await http.get(Uri.parse(
        'https://masak-apa-hari-ini-34bg.vercel.app/api/article/$key'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Recipe(
        key: key,
        image: data['results']['thumb'],
        title: data['results']['title'],
      );
    } else {
      throw Exception('Failed to fetch recipe: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simpanan Resep'),
      ),
      body: ListView.builder(
        itemCount: savedRecipes.length,
        itemBuilder: (context, index) {
          String? recipeData = savedRecipes[index];
          if (recipeData != null) {
            Map<String, dynamic> recipe = jsonDecode(recipeData);
            String? title = recipe['title'];
            String? image = recipe['image'];

            return Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResepPageDetail(
                        recipe: Recipe(
                          key: recipe['key'] ?? '',
                          title: title ?? '',
                          image: image ?? '',
                        ),
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        if (image != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              image,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            title ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container(
              child: Text('Data tidak ditemukan'),
            );
          }
        },
      ),
    );
  }
}
