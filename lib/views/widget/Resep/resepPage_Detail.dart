import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter12/models/model.dart';
import 'package:flutter12/models/api_service.dart';
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

  void initState() {
    super.initState();
    recipeDetailFuture = fetchRecipeDetail(widget.recipe.key);
    // recipeDetailFuture = fetchRecipeDetail(widget.recipe.key);
  }

  // panggil fetch data dari api_service.dart ke sini
  Future<RecipeDetail> fetchRecipeDetail(String key) async {
    final response = await http.get(Uri.parse(
        'https://masak-n47txy691-tomorisakura.vercel.app/api/recipe/$key'));
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
        // step: List<String>.from(data['results']['step']),
      );
    } else {
      throw Exception('Failed to fetch recipe detail: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<RecipeDetail>(
            future: recipeDetailFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                // return _buildRecipeDetail(snapshot.data!);
                final recipeDetail = snapshot.data!;

                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      pinned: true,
                      snap: true,
                      expandedHeight: 400,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                          widget.recipe.image,
                          // recipe.image!,
                          // fit: BoxFit.cover,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(widget.recipe.title),
                      // Text(recipe.title!),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Container(
                          child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                widget.recipe.title,
                                // recipe.title,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              size: 20,
                                              color: Colors.black,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Oleh: ${recipeDetail.author['user']}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              size: 20,
                                              color: Colors.black,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              'Tanggal: ${recipeDetail.author['datePublished']}',
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
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
                        crossAxisCount: 1,
                        childAspectRatio: 6,
                      ),
                      delegate: SliverChildListDelegate(
                        [
                          Container(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(left: 100, right: 100),
                            decoration: BoxDecoration(
                              // color: Colors.blueGrey[50],
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  // color: Colors.blueGrey[50],
                                  width: 0.1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Waktu Memasak',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  recipeDetail.times,
                                  style: TextStyle(
                                    fontSize: 14,
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
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Deskripsi',
                                    ),
                                    SizedBox(),
                                    Text(
                                      recipeDetail.desc,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ])),
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bahan - Bahan',
                                    ),
                                    SizedBox(),
                                    Text(
                                      recipeDetail.ingredient.join('\n'),
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ]))
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
