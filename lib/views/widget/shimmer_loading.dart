import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerLoadingWidget = GridView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 1,
    childAspectRatio: 0.7,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  ),
  itemCount: 1, // Jumlah shimmer loading yang ingin ditampilkan
  itemBuilder: (BuildContext context, int index) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white,
      ),
    );
  },
);

Widget shimmerLoadingScrollPage = Container(
  margin: const EdgeInsets.symmetric(horizontal: 10),
  child: Card(
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.white,
          ),
        ],
      ),
    ),
  ),
);

Widget shimmerLoadingSliderPage = Container(
  margin: const EdgeInsets.symmetric(horizontal: 45),
  child: Card(
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            color: Colors.white,
          ),
        ],
      ),
    ),
  ),
);
