import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:maskara/models/model.dart';
import 'package:maskara/models/api_service.dart';
import 'package:http/http.dart' as http;

class ArtikelPageDetail extends StatefulWidget {
  final Artikel artikel;
  const ArtikelPageDetail({Key? key, required this.artikel}) : super(key: key);

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
        'https://masak-apa-hari-ini-34bg.vercel.app/api/article/$key'));
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
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final artikelDetail = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  snap: true,
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      widget.artikel.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.artikel.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Text(
                                'By ${artikelDetail.author} | ${artikelDetail.date}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            artikelDetail.desc,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}
