import 'package:flutter/material.dart';

class ScrollPage extends StatelessWidget {
  const ScrollPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          toolbarHeight: 120,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Temukan Masakan\nNusantaramu',
              style: TextStyle(fontSize: 32),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
            SizedBox(width: 10),
          ],
          pinned: true,
          floating: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Temukan Resep Makananmu Berdasarkan Kategori',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward_rounded),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(width: 10),
                          Container(
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
                                  SizedBox(height: 10),
                                  Text('Makanan Berat'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
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
                                  SizedBox(height: 10),
                                  Text('Makanan Ringan'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
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
                                  SizedBox(height: 10),
                                  Text('Makanan Penutup'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
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
                                  SizedBox(height: 10),
                                  Text('Makanan Minuman'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
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
          delegate: SliverChildListDelegate([
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          'Rekomendasi Resep Makananmu',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_forward_rounded),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_960_720.jpg',
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('Makanan Berat'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                                'https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_960_720.jpg'),
                          ),
                          SizedBox(height: 10),
                          Text('Makanan Ringan'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ),
      ],
    );
  }
}
