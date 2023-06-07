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
      body: TopBarFb2(
          title: 'Cari Masakan Berdasarkan Kategori',
          icon: Icon(Icons.arrow_back_ios)),
      bottomNavigationBar: BottomNavBarFb2(),
    );
  }
}
