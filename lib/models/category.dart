import 'package:flutter/foundation.dart';

class Category {
  final String id;
  final String name;
  final String thumbUrl;
  final String description;

  Category({
    @required this.id,
    @required this.name,
    @required this.thumbUrl,
    @required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory'],
      name: json['strCategory'],
      thumbUrl: json['strCategoryThumb'],
      description: json['strCategoryDescription'],
    );
  }

  static List<String> categoriesName = [
    'Beef',
    'Chicken',
    'Dessert',
    'Lamb',
    'Miscellaneous',
    'Past',
    'Pork',
    'Seafood',
    'Side',
    'Starter',
    'Vegan',
    'Vegetarian',
    'Breakfast',
    'Goat'
  ];
}
