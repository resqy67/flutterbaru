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
        //buatkan sliverPersistentHeader dengan tab detail dan bahan bahan nya
        // SliverPersistentHeader(
        //   delegate: _SliverPersistentHeader(
        //     TabBar(
        //       tabs: [
        //         Tab(
        //           text: 'Detail',
        //         ),
        //         Tab(
        //           text: 'Bahan',
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        SliverList(delegate: SliverChildBuilderDelegate(((context, index) {
          return const ListTile(
            title: Text('data'),
          );
        })))
      ],
    ));
  }
}
