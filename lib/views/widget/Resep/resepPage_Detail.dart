import 'package:flutter/material.dart';

class ResepPageDetail extends StatelessWidget {
  const ResepPageDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          pinned: true,
          snap: true,
          expandedHeight: 400,
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
                    'Resep Makanan',
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
        // buatkan slivergrid untuk menampilkan kalori dan waktu memasak
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
          ),
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                  // color: Colors.blueGrey[50],
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      // color: Colors.blueGrey[50],
                      width: 0.1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Kalori',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1000',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 25, right: 25),
                decoration: BoxDecoration(
                  // color: Colors.blueGrey[50],
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      // color: Colors.blueGrey[50],
                      width: 0.1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Waktu Memasak',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1000',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

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
                          'Deskripsi',
                        ),
                        SizedBox(),
                        Text(
                            'lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet lorem ipsum dolor sit amet'),
                      ])),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Bahan-bahan',
                        ),
                        SizedBox(),
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
