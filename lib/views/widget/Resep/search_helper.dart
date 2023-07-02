import 'package:maskara/models/model.dart';

class SearchHelper {
  static List<Recipe> searchRecipes(List<Recipe> recipes, String query) {
    final searchResults = recipes
        .where((recipe) =>
            recipe.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return searchResults;
  }
}
