import 'package:flutter/material.dart';
import 'package:flutter12/views/widget/bottomNavBar.dart';
import 'package:flutter12/views/widget/scrollPage.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Temukan Masakan Nusantaramu',
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
      body: const ScrollPage(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
