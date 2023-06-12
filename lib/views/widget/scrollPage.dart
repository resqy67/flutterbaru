import 'package:flutter/material.dart';
import 'package:flutter12/views/widget/resepPage.dart';
import 'package:flutter12/views/widget/categoryPage.dart';

class ScrollPage extends StatelessWidget {
  const ScrollPage({
    Key? key,
  }) : super(key: key);

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
      slivers: [
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
                                      builder: (context) => const CategoryPage()));
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
                                        'https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_960_720.jpg',
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
                      child: Column(
                        children: [
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
                                    // navigate ke halaman resepPage
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const ResepPage()));
                                  },
                                  icon: const Icon(Icons.arrow_forward_rounded),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
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
                                    const SizedBox(height: 10),
                                    const Text('Makanan Berat'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
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
                                    const SizedBox(height: 10),
                                    const Text('Makanan Ringan'),
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
