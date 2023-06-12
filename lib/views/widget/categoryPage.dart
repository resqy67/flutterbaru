import 'package:flutter/material.dart';
import 'package:flutter12/views/widget/bottomnavbar.dart';
// import 'package:flutter12/views/widget/bottomNavBar.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Temukan Kategorinya',
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          SizedBox(width: 10),
        ],
      ),
      bottomNavigationBar: bottomNavBar(),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          // slivergrid
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  width: 150,
                  color: Colors.black,
                  // color: Colors.amberAccent,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.amber,
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
                        SizedBox(height: 10),
                        Text(
                          'kategori',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
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
