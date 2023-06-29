import 'package:flutter/material.dart';
import 'package:flutter12/views/widget/artikel/artikelPage_detail.dart';
import 'package:flutter12/views/widget/bottomNavBar.dart';
import 'package:flutter12/models/model.dart';
import 'package:flutter12/models/api_service.dart';

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
        final jsonData = await apiService.fetchArtikel(page);
        List<Artikel> newArtikels = [];
        for (var recipe in jsonData) {
          newArtikels.add(Artikel(
              image: recipe['thumb'],
              title: recipe['title'],
              key: recipe['key']));
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
  } // fetch data

  // dispose
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
                if (index == artikels.length) {
                  if (isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Container(
                        child: Center(
                      child: TextButton(
                        onPressed: () {
                          fetchData(currentPage);
                        },
                        child: Text('Load More'),
                      ),
                    )); // Render an empty container if no more data is available
                  }
                }
                var recipe = artikels[index];
                return Container(
                  child: InkWell(
                    onTap: () {
                      navigateToArtikelDetail(recipe);
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
                            borderRadius: BorderRadius.circular(10),
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
              childCount: artikels.length + 1,
            ),
          ),
        ],
      ),
    );
  }
}
