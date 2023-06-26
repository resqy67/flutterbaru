import 'package:flutter/material.dart';
import 'package:flutter12/views/home.dart';
import 'package:flutter12/views/widget/Artikel/artikelPage.dart';
import 'package:flutter12/views/widget/Category/categoryPage.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'Artikel',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_rounded),
          label: 'Category',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        if (_selectedIndex == 0) {
          // Index 1 adalah menu 'Artikel'
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Homepage(),
            ),
          );
        }
        if (_selectedIndex == 1) {
          // Index 1 adalah menu 'Artikel'
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArtikelPage(),
            ),
          );
        }
        if (_selectedIndex == 2) {
          // Index 1 adalah menu 'Artikel'
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryPage(),
            ),
          );
        }
      },
      selectedItemColor: Colors.blue, // Warna ikon dan teks menu aktif
      unselectedItemColor: Colors.grey,
    );
  }
}
