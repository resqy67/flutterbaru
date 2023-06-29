import 'package:flutter/material.dart';
import 'package:flutter12/views/widget/Resep/resepPage.dart';
import 'package:flutter12/views/widget/Category/categoryPage.dart';
import 'package:flutter12/views/widget/Resep/resepPage_Detail.dart';

import 'package:flutter12/models/model.dart';
import 'package:flutter12/models/api_service.dart';
import 'package:flutter12/models/kategori.dart';

class ScrollPage extends StatefulWidget {
  const ScrollPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ScrollPage> createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {
  final ApiService apiService = ApiService();

  List<Recipe> recipes = [];
  List<Category> categorys = [];
  int currentPage = 1;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  // konidi state untuk fetch data
  @override
  void initState() {
    super.initState();
    fetchData(currentPage);
    // fetchCategory('category', currentPage);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchData(currentPage);
      }
    });
  }

  // fetch data
  Future<void> fetchData(int page) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      try {
        final jsonData = await apiService.fetchRecipes(page);
        List<Recipe> newRecipes = [];
        for (var recipe in jsonData) {
          newRecipes.add(Recipe(
              image: recipe['thumb'],
              title: recipe['title'],
              key: recipe['key']));
        }
        setState(() {
          recipes.addAll(newRecipes);
          currentPage++;
          isLoading = false;
        });
      } catch (e) {
        print(e);
        // Handle error
      }
    }
  }

  // dispose
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void navigateToRecipeDetail(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResepPageDetail(recipe: recipe),
      ),
    );
  }

  void _showPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Popup'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Temukan Resep Makananmu Berdasarkan Kategori',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CategoryPage(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.arrow_forward_rounded),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: 150,
                        // flex: 1,
                        child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              const SizedBox(width: 10),
                              InkWell(
                                onTap: () {
                                  _showPopup(context, 'Makanan Berat');
                                },
                                child: SizedBox(
                                  width: 150,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            'https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_960_720.jpg',
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        // panggil text dari fetch data
                                        Text(
                                          'Makanan Berat',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ])),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          const Text(
                            'Rekomendasi Resep Makananmu',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ResepPage(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.arrow_forward_rounded),
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
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index == recipes.length) {
                if (isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Container(); // Render an empty container if no more data is available
                }
              }
              var recipe = recipes[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    // hubungkan ke halaman detail
                    navigateToRecipeDetail(recipe);
                  },
                  child: Card(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            recipe.image,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          recipe.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: recipes.length + 1,
          ),
        ),
      ],
    );
  }
}
