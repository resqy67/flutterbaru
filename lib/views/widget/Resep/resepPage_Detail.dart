import 'dart:convert';
import 'dart:math';
import 'package:maskara/views/widget/resep/resepPage_Detail.dart';
import 'package:maskara/views/widget/save/savePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:maskara/models/model.dart';
import 'package:maskara/models/api_service.dart';
// import 'package:flutter12/views/widget/Save/savePage.dart';
import 'package:http/http.dart' as http;
// import '../../../models/recipe.dart';

class ResepPageDetail extends StatefulWidget {
  final Recipe recipe;
  const ResepPageDetail({Key? key, required this.recipe}) : super(key: key);
  // const RecipeDetailPage({required this.recipe});

  @override
  State<ResepPageDetail> createState() => _ResepPageDetailState();
}

class _ResepPageDetailState extends State<ResepPageDetail> {
  final ApiService apiService = ApiService();
  late Future<RecipeDetail> recipeDetailFuture;
  bool isRecipeSaved = false;

  void initState() {
    super.initState();
    recipeDetailFuture = fetchRecipeDetail(widget.recipe.key);
    _checkRecipeSaved();
    // isSaved = SavedRecipes.savedRecipes.contains(widget.recipe);
    // recipeDetailFuture = fetchRecipeDetail(widget.recipe.key);
  }

  void _saveRecipe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedRecipes = prefs.getStringList('savedRecipes');

    if (savedRecipes == null) {
      savedRecipes = [];
    }

    Map<String, String> savedRecipe = {
      'key': widget.recipe.key,
      'title': widget.recipe.title,
      'image': widget.recipe.image,
    };

    savedRecipes.add(jsonEncode(savedRecipe));

    await prefs.setStringList('savedRecipes', savedRecipes);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Resep telah disimpan'),
      ),
    );
    setState(() {
      isRecipeSaved = true;
    });
  }

  void _removeRecipe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedRecipes = prefs.getStringList('savedRecipes');
    if (savedRecipes == null) {
      return;
    }

    Map<String, String> savedRecipe = {
      'key': widget.recipe.key,
      'title': widget.recipe.title,
      'image': widget.recipe.image,
    };

    savedRecipes.remove(jsonEncode(savedRecipe));

    await prefs.setStringList('savedRecipes', savedRecipes);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Resep dihapus dari simpanan'),
      ),
    );

    setState(() {
      isRecipeSaved = false;
    });
  }

  void _checkRecipeSaved() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> savedRecipes =
        (prefs.getStringList('savedRecipes') ?? []).map((recipeJson) {
      return jsonDecode(recipeJson) as Map<String, dynamic>;
    }).toList();

    setState(() {
      isRecipeSaved =
          savedRecipes.any((recipe) => recipe['key'] == widget.recipe.key);
    });
  }

  Future<RecipeDetail> fetchRecipeDetail(String key) async {
    final response = await http.get(Uri.parse(
        'https://masak-apa-hari-ini-34bg.vercel.app/api/recipe/$key'));
    // final jsonData = await apiService.fetchRecipeDetail(key);
    // print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return RecipeDetail(
        title: data['results']['title'],
        thumb: data['results']['thumb'],
        times: data['results']['times'],
        difficulty: data['results']['difficulty'],
        author: data['results']['author'],
        // date: data['results']['datePublished'],
        desc: data['results']['desc'],
        // needItem: List<String>.from(data['results']['needItem']),
        ingredient: List<String>.from(data['results']['ingredient']),
        step: List<String>.from(data['results']['step']),
      );
    } else {
      throw Exception('Failed to fetch recipe detail: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // bool isSaved = SavedRecipes.savedRecipes.contains(widget.recipe);
    return Scaffold(
        body: FutureBuilder<RecipeDetail>(
            future: recipeDetailFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final recipeDetail = snapshot.data!;

                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      pinned: true,
                      snap: true,
                      expandedHeight: 350,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                          widget.recipe.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            isRecipeSaved ? _removeRecipe() : _saveRecipe();
                            // if (isRecipeSaved) {
                            //   _removeRecipe();
                            // } else {
                            //   _saveRecipe();
                            // }
                            isRecipeSaved = !isRecipeSaved;
                          },
                          icon: Icon(
                              isRecipeSaved
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: Colors.white),
                        ),
                      ],
                      // title: Text(widget.recipe.title),
                    ),
                    SliverList(
                        // berikan rounded rectangle border pada container

                        delegate: SliverChildListDelegate([
                      Container(
                          child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 30, top: 20, right: 30, bottom: 10),
                              child: Text(
                                widget.recipe.title,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 30,
                                        // top: 20,
                                        right: 30,
                                        bottom: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            // Icon(
                                            //   Icons.person,
                                            //   size: 20,
                                            //   color: Colors.black,
                                            // ),
                                            // SizedBox(width: 5),
                                            Text(
                                              '${recipeDetail.author['user']}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            // Icon(
                                            //   Icons.calendar_today,
                                            //   size: 20,
                                            //   color: Colors.black,
                                            // ),
                                            // SizedBox(width: 5),
                                            Text(
                                              '${recipeDetail.author['datePublished']}',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                    ])),
                    // buatkan slivergrid untuk menampilkan kalori dan waktu memasak
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                      ),
                      delegate: SliverChildListDelegate(
                        [
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              // color: Colors.blueGrey[50],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.blueGrey[50]!, width: 3),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Waktu Memasak',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        recipeDetail.times,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              // color: Colors.blueGrey[50],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.blueGrey[50]!, width: 3),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Tingkat Kesulitan',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        recipeDetail.difficulty,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Container(
                          child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 5),
                                      child: Text('About Recipe',
                                          // textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '\t\t\t\t\t\t\t\t${recipeDetail.desc}',
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[800],
                                      ),
                                      strutStyle: StrutStyle(
                                        height: 1.7,
                                      ),
                                    ),
                                  ])),
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20, top: 10)),
                                    Text('Bahan - Bahan',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: recipeDetail.ingredient
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        // int stepIng = entry.key + 1;
                                        String ingredient = entry.value;
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20, bottom: 1),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                // '$stepIng.',
                                                '-',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  ingredient,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    )
                                  ])),
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Cara Memasak',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: recipeDetail.step
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        int stepNumber = entry.key + 1;
                                        String step = entry.value;
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: 20, right: 20, bottom: 1),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '$stepNumber.',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  step,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    )
                                  ])),
                        ],
                      )),
                    ]))
                  ],
                );
              } else {
                return const Center(child: Text('No data'));
              }
            }));
  }
}
