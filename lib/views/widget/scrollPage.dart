import 'package:flutter/material.dart';
import 'package:flutter12/views/widget/Resep/resepPage.dart';
import 'package:flutter12/views/widget/Category/categoryPage.dart';
import 'package:flutter12/views/widget/Resep/resepPage_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Recipe {
  final String image;
  final String title;

  Recipe({required this.image, required this.title});
}

class ScrollPage extends StatefulWidget {
  const ScrollPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ScrollPage> createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {
  final String apiUrl =
      "https://masak-n47txy691-tomorisakura.vercel.app/api/recipes";
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

  // fetch data
  Future<void> fetchData(int page) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var response = await http.get(Uri.parse("$apiUrl?page=$page"));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['results'];
        List<Recipe> newRecipes = [];
        for (var recipe in jsonData) {
          newRecipes
              .add(Recipe(image: recipe['thumb'], title: recipe['title']));
        }
        setState(() {
          recipes.addAll(newRecipes);
          currentPage++;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    }
  }

  // dispose
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_960_720.jpg',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text('Makanan Berat'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              _showPopup(context, 'Makanan Ringan');
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
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'https://www.masakapahariini.com/wp-content/uploads/2020/09/resep-dimsum-ayam-final-500x300.jpg',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text('Makanan Ringan'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              _showPopup(context, 'Makanan Penutup');
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
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_960_720.jpg',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text('Makanan Penutup'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              _showPopup(context, 'Makanan Minuman');
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
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_960_720.jpg',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text('Makanan Minuman'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
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
                    // hubungkan ke artikel detail
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResepPageDetail(),
                      ),
                    );
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
