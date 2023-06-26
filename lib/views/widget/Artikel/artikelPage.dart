import 'package:flutter/material.dart';
import 'package:flutter12/views/widget/artikel/artikelPage_detail.dart';
import 'package:flutter12/views/widget/bottomNavBar.dart';

class ArtikelPage extends StatelessWidget {
  const ArtikelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Temukan Artikel Terbaru',
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
        shrinkWrap: true,
        slivers: [
          // slivergrid
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ArtikelPageDetail()));
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
                              'https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_960_720.jpg',
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'ini nama artikel',
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
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
