import 'package:flutter/material.dart';

class ArtikelPageDetail extends StatelessWidget {
  const ArtikelPageDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          snap: true,
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              'https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_960_720.jpg',
              fit: BoxFit.cover,
            ),
          ),
          title: const Text('ini makanannya'),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
              child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Judul artikel',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'oleh: siapa',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Tanggal publish',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ))
        ])),
        // buatkan sliverlist untuk menampilkan detail resep makanan yang terdiri dari deskripsi dan bahan-bahan yang dibutuhkan untuk membuat makanan tersebut (gunakan ListTile)
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
              child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            'lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet'),
                      ])),
            ],
          )),
        ]))
      ],
    ));
  }
}
