import 'package:flutter/material.dart';
import 'package:flutter12/views/widget/bottomNavBar.dart';
import 'package:flutter12/views/widget/coba.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Temukan Masakan\n Nusantaramu',
              style: TextStyle(fontSize: 32),
            ),
            Spacer(),
            Icon(Icons.search),
            SizedBox(width: 10),
          ],
        ),
      ),
      body: Container(
          child: Column(
        children: [
          // pada bagian ini adalah text untuk menampilkan kategori
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                Text(
                  'Temukan Resep Makananmu Berdasarkan Kategori',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.arrow_forward_rounded)),
              ],
            ),
          ),
          // pada bagian ini adalah card kategori
          Container(
              child: Column(children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 335,
                height: 190,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 335,
                        height: 110,
                        child: Image.network(
                          'https://via.placeholder.com/300?text=DITTO',
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Column(children: [Text('Title'), Text('Subtitle')])
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(9),
                ),
              ),
            ),
          ]))
        ],
      )),
    );
  }
}
