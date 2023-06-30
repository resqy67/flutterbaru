import 'package:flutter/material.dart';
import 'package:flutter12/views/widget/artikel/artikelPage_detail.dart';
import 'package:flutter12/views/widget/bottomNavBar.dart';
import 'package:flutter12/models/model.dart';
import 'package:flutter12/models/api_service.dart';
import 'package:shimmer/shimmer.dart';

class ArtikelPage extends StatefulWidget {
  const ArtikelPage({Key? key}) : super(key: key);

  @override
  State<ArtikelPage> createState() => _ArtikelPageState();
}

class _ArtikelPageState extends State<ArtikelPage> {
  final ApiService apiService = ApiService();

  List<Artikel> artikels = [];
  int currentPage = 1;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

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
        final jsonData = await apiService.fetchArtikel(page);
        List<Artikel> newArtikels = [];
        for (var recipe in jsonData) {
          newArtikels.add(Artikel(
            image: recipe['thumb'],
            title: recipe['title'],
            key: recipe['key'],
          ));
        }
        setState(() {
          artikels.addAll(newArtikels);
          currentPage++;
          isLoading = false;
        });
      } catch (e) {
        print(e);
        // Handle error
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void navigateToArtikelDetail(Artikel artikel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArtikelPageDetail(artikel: artikel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Temukan Artikelnya',
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
      body: GridView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 8,
          mainAxisSpacing: 10,
        ),
        itemCount: artikels.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == artikels.length) {
            if (isLoading) {
              return _buildShimmerLoading();
              // return Center(child: CircularProgressIndicator());
            } else {
              return Container(
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      fetchData(currentPage);
                    },
                    child: Text('Load More'),
                  ),
                ),
              );
            }
          }
          var recipe = artikels[index];
          return InkWell(
            onTap: () {
              navigateToArtikelDetail(recipe);
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
          );
        },
      ),
    );
  }
}

Widget _buildShimmerLoading() {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      childAspectRatio: 0.7,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
    ),
    itemCount: 1, // Jumlah shimmer loading yang ingin ditampilkan
    itemBuilder: (BuildContext context, int index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.white,
        ),
      );
    },
  );
}
