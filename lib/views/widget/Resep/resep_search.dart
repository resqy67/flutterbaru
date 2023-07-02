import 'package:flutter/material.dart';
import 'package:maskara/models/model.dart';
import 'package:maskara/views/widget/resep/resepPage_Detail.dart';
import 'package:maskara/views/widget/resep/navigation_helper.dart';
import 'package:maskara/views/widget/resep/search_helper.dart';

class RecipeSearchDelegate extends SearchDelegate<String> {
  final List<Recipe> recipes;
  final String initialQuery;
  final Function(String, List<Recipe>) onSearch;

  RecipeSearchDelegate(this.recipes, this.initialQuery, this.onSearch);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchResults = SearchHelper.searchRecipes(recipes, query);
    onSearch(query, searchResults);
    return _buildRecipeList(searchResults);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchResults = SearchHelper.searchRecipes(recipes, query);
    return _buildRecipeList(searchResults);
  }

  Widget _buildRecipeList(List<Recipe> recipes) {
    // Implement your recipe list widget here
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return InkWell(
          onTap: () {
            navigateToRecipeDetail(context, recipe);
          },
          child: ListTile(
            title: Text(recipe.title),
          ),
        );
      },
    );
  }
}
