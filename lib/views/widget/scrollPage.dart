import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:maskara/views/widget/Artikel/artikelPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:maskara/views/widget/Resep/resepPage.dart';
import 'package:maskara/views/widget/save/savePage.dart';
import 'package:maskara/views/widget/Resep/resepPage_Detail.dart';

import 'package:maskara/models/model.dart';
import 'package:maskara/models/api_service.dart';
import 'package:maskara/models/kategori.dart';

import 'package:maskara/views/widget/shimmer_loading.dart';

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
  List<Map<String, dynamic>> slideShowData = [];
  int currentPage = 1;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

  // konidi state untuk fetch data
  @override
  void initState() {
    super.initState();
    fetchData(currentPage);
    fetchSlideShow();
    // fetchCategory('category', currentPage);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        fetchData(currentPage);
        fetchSlideShow();
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

  Future<void> fetchSlideShow() async {
    final response = await http.get(Uri.parse(
        'https://masak-apa-hari-ini-34bg.vercel.app/api/category/article/makanan-gaya-hidup'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['status'] == true) {
        setState(() {
          slideShowData = List<Map<String, dynamic>>.from(jsonData['results']);
        });
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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          // buatkan app bar dengan tulisan 'Temukan Masakan Nusantaramu'
          title: const Text(
            'Temukan Masakan Nusantaramu',
            style: TextStyle(fontSize: 20),
          ),
        ),
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
                            'Artikel yang Mungkin Kamu Suka',
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
                                  builder: (context) => const ArtikelPage(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.arrow_forward_rounded),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        isLoading
                            ? Center(
                                child: shimmerLoadingSliderPage,
                              )
                            : CarouselSlider(
                                options: CarouselOptions(
                                  // height: 200,
                                  height: MediaQuery.of(context).size.height *
                                      0.215,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: true,
                                  autoPlay: true,
                                ),
                                items: slideShowData.map((item) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Card(
                                          child: ClipRRect(
                                            // berikan text di dalam image
                                            child: Stack(
                                              children: [
                                                Image.network(
                                                  item['thumb'],
                                                  fit: BoxFit.cover,
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8,
                                                            horizontal: 16),
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    child: Text(
                                                      item['title'],
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                      ],
                    ),
                    const SizedBox(height: 10),
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
                  // return Center(child: CircularProgressIndicator());
                  return shimmerLoadingScrollPage;
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
                          // berikan rounded corners di image
                          borderRadius: BorderRadius.circular(8),
                          // berikan text di dalam image dengan menggunakan stack
                          child: Stack(
                            children: [
                              Image.network(
                                recipe.image,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                bottom: 80,
                                top: 80,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  color: Colors.black.withOpacity(0.5),
                                  child: Text(
                                    recipe.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // borderRadius: BorderRadius.circular(10),
                          // child: Image.network(
                          //   recipe.image,
                          // ),
                        ),
                        // const SizedBox(height: 10),
                        // Text(
                        //   recipe.title,
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //       fontSize: 15, fontWeight: FontWeight.w500),
                        // ),
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
