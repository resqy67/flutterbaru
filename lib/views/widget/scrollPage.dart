import 'package:flutter/material.dart';
import 'package:flutter12/views/categoryPage.dart';
import 'package:flutter12/views/resepPage.dart';

class ScrollPage extends StatelessWidget {
  const ScrollPage({
    Key? key,
  }) : super(key: key);

  void _showPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Popup'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
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
      slivers: [
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
                            onPressed: () {
                              // navigate ke halaman kategoriPage
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryPage()));
                            },
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
                          InkWell(
                            onTap: () {
                              _showPopup(context, 'Makanan Berat');
                            },
                            child: Container(
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
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              _showPopup(context, 'Makanan Ringan');
                            },
                            child: Container(
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
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              _showPopup(context, 'Makanan Penutup');
                            },
                            child: Container(
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
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              _showPopup(context, 'Makanan Minuman');
                            },
                            child: Container(
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
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
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
                                  onPressed: () {
                                    // navigate ke halaman resepPage
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ResepPage()));
                                  },
                                  icon: Icon(Icons.arrow_forward_rounded),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: () {
                                _showPopup(context, 'Makanan Berat');
                              },
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
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: () {
                                _showPopup(context, 'Makanan Ringan');
                              },
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
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
