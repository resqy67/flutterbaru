import 'package:flutter/material.dart';
import 'package:flutter12/views/widget/bottomnavbar.dart';
// import 'package:flutter12/views/widget/bottomNavBar.dart';
// bottomNavBar

class ArtikelPage extends StatelessWidget {
  const ArtikelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artikel'),
      ),
      body: Center(
        child: Text('Artikel Page'),
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }
}
