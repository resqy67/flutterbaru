import 'package:flutter/material.dart';
import 'package:flutter12/views/widget/bottomNavBar.dart';
import 'package:flutter12/views/widget/resep/resepPage_Detail.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter12/models/api_service.dart';
import 'dart:convert';

class Recipe {
  final String image;
  final String title;

  Recipe({required this.image, required this.title});
}

class ResepPage extends StatefulWidget {
  const ResepPage({Key? key}) : super(key: key);

  @override
  State<ResepPage> createState() => _ResepPageState();
}

class _ResepPageState extends State<ResepPage> {
  // api url
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
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 10),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
      body: CustomScrollView(
        controller: _scrollController,
        shrinkWrap: true,
        slivers: [
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
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
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResepPageDetail()));
                    },
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                      shadowColor: Colors.grey,
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            // borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              recipe.image,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            recipe.title,
                            style: TextStyle(
                              fontSize: 12,
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
