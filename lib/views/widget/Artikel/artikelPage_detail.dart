import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter12/models/model.dart';
import 'package:flutter12/models/api_service.dart';
import 'package:http/http.dart' as http;

class ArtikelPageDetail extends StatefulWidget {
  // map string dynamic from artikel page
  // final Map<String, dynamic> artikel;

  // const ArtikelPageDetail({Key? key, required this.artikel}) : super(key: key);
  final Artikel artikel;
  const ArtikelPageDetail({super.key, required this.artikel});

  @override
  State<ArtikelPageDetail> createState() => _ArtikelPageDetailState();
}

class _ArtikelPageDetailState extends State<ArtikelPageDetail> {
  final ApiService apiService = ApiService();
  late Future<ArtikelDetail> artikelDetailFuture;

  void initState() {
    super.initState();
    artikelDetailFuture = fetchArtikelDetail(widget.artikel.key);
  }

  Future<ArtikelDetail> fetchArtikelDetail(String key) async {
    final response = await http.get(Uri.parse(
        'https://masak-n47txy691-tomorisakura.vercel.app/api/article/$key'));
    // final jsonData = await apiService.fetchRecipeDetail(key);
    // print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ArtikelDetail(
        title: data['results']['title'],
        thumb: data['results']['thumb'],
        author: data['results']['author'],
        desc: data['results']['description'],
        date: data['results']['date_published'],
      );
    } else {
      throw Exception('Failed to fetch recipe detail: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<ArtikelDetail>(
      future: artikelDetailFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          // return _buildRecipeDetail(snapshot.data!);
          final artikelDetail = snapshot.data!;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: true,
                expandedHeight: 150,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    widget.artikel.image,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(widget.artikel.title),
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                Container(
                    child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          widget.artikel.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                                        'oleh: ${artikelDetail.author}',
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
                                        '${artikelDetail.date}',
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
                                '\u2003${artikelDetail.desc}',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ])),
                  ],
                )),
              ]))
            ],
          );
        } else {
          return const Center(child: Text('No data'));
        }
      },
    ));
  }
}
