import 'package:flutter/material.dart';
import 'package:maskara/views/widget/Artikel/artikelPage.dart';
import 'package:maskara/views/widget/Save/savePage.dart';
import 'package:maskara/views/widget/scrollPage.dart';

Widget buildBody(int selectedIndex) {
  switch (selectedIndex) {
    case 0:
      return ScrollPage();
    case 1:
      return ArtikelPage();
    case 2:
      return SavePage();
    default:
      return Container();
  }
}

Widget buildBottomNavigationBar(int selectedIndex, Function(int) onTabTapped) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.article),
        label: 'Artikel',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.bookmark),
        label: 'Bookmark',
      ),
    ],
    currentIndex: selectedIndex,
    selectedItemColor: Colors.blue,
    onTap: onTabTapped,
  );
}
