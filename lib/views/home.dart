import 'package:flutter/material.dart';
import 'package:flutter12/views/widget/bottomnavbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Temukan Masakan Nusantaramu',
      //     style: TextStyle(fontSize: 20),
      //   ),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.search),
      //     ),
      //     const SizedBox(width: 10),
      //   ],
      // ),
      body: buildBody(_selectedIndex),
      bottomNavigationBar:
          buildBottomNavigationBar(_selectedIndex, _onTabTapped),
    );
  }
}
