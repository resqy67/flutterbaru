class Recipe {
  final String image;
  final String title;
  final String key;

  Recipe({
    required this.image,
    required this.title,
    required this.key,
  });

  // Object? toJson() {}

  // static fromJson(jsonDecode) {}
}

class RecipeDetail {
  final String title;
  final String thumb;
  final String times;
  final String difficulty;
  final Map<String, dynamic> author;

  final String desc;
  final List<String> ingredient;

  RecipeDetail({
    required this.title,
    required this.thumb,
    required this.times,
    required this.difficulty,
    required this.author,
    required this.desc,
    required this.ingredient,
  });

  // get key => null;
  // RecipeDetail({
  //   required this.title,
  //   required this.thumb,
  //   required this.times,
  //   required this.difficulty,
  //   required this.author,
  //   required this.desc,
  //   required this.ingredient,
  // });
}

class Artikel {
  final String title;
  final String image;
  final String key;

  Artikel({
    required this.title,
    required this.image,
    required this.key,
  });
}

class ArtikelDetail {
  final String title;
  final String thumb;
  final String author;
  final String date;
  final String desc;

  ArtikelDetail({
    required this.title,
    required this.thumb,
    required this.author,
    required this.date,
    required this.desc,
  });
  // Map<String, dynamic> toJson() {
  //   return {
  //     'author': author,
  //     'title': title,
  //     'thumb': thumb,
  //     'date': date,
  //     'description': desc,
  //   };
  // }
}
