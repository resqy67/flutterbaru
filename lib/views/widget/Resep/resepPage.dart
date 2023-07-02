import 'package:flutter/material.dart';
import 'package:maskara/views/widget/Resep/resep_search.dart';
import 'package:maskara/views/widget/Resep/search_helper.dart';
import 'package:maskara/views/widget/bottomNavBar.dart';
import 'package:maskara/views/widget/resep/resepPage_Detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:maskara/models/model.dart';
import 'package:maskara/models/api_service.dart';
import 'package:maskara/views/widget/Resep/navigation_helper.dart';
import 'package:maskara/views/widget/shimmer_loading.dart';

class ResepPage extends StatefulWidget {
  const ResepPage({Key? key}) : super(key: key);

  @override
  State<ResepPage> createState() => _ResepPageState();
}

class _ResepPageState extends State<ResepPage> {
  final ApiService apiService = ApiService();

  List<Recipe> recipes = [];
  int currentPage = 1;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  // konidi state untuk fetch data
  @override
  void initState() {
    super.initState();
    fetchData(currentPage);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchData(currentPage);
      }
    });
  }

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
  } // fetch data

  void _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: RecipeSearchDelegate(
        recipes,
        '',
        (query, results) {
          // Handle search results
        },
      ),
    );
  }

  // dispose
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // void navigateToRecipeDetail(Recipe recipe) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ResepPageDetail(recipe: recipe),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Temukan Resepnya',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showSearch(context);
            },
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 10),
        ],
      ),
      // bottomNavigationBar: BottomNavBar(),
      body: CustomScrollView(
        controller: _scrollController,
        shrinkWrap: true,
        slivers: [
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 8,
              mainAxisSpacing: 10,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == recipes.length) {
                  if (isLoading) {
                    // return Center(child: CircularProgressIndicator());
                    return shimmerLoadingWidget;
                  } else {
                    return Container(); // Render an empty container if no more data is available
                  }
                }
                var recipe = recipes[index];
                return Container(
                  child: InkWell(
                    onTap: () {
                      navigateToRecipeDetail(context, recipe);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                      shadowColor: Colors.grey,
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                recipe.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    recipe.title,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  // const SizedBox(height: 5),
                                  // Text(
                                  //   'Author: John Doe',
                                  //   style: TextStyle(fontSize: 12),
                                  // ),
                                ],
                              ),
                            ),
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
      ),
    );
  }
}
