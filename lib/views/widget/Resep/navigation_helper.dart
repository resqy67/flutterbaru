import 'package:flutter/material.dart';
import 'package:maskara/models/model.dart';
import 'package:maskara/views/widget/Resep/resepPage_Detail.dart';

void navigateToRecipeDetail(BuildContext context, Recipe recipe) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ResepPageDetail(recipe: recipe),
    ),
  );
}
