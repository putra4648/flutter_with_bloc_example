import 'package:flutter/foundation.dart';

class Meal {
  final String id;
  final String mealName;
  final String category;
  final String region;
  final String instruction;
  final String thumbnailUrl;
  final String tags;
  final List ingredients;
  final List measures;

  Meal({
    @required this.id,
    @required this.mealName,
    @required this.category,
    @required this.region,
    @required this.instruction,
    @required this.thumbnailUrl,
    @required this.tags,
    @required this.ingredients,
    @required this.measures,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List ingredients = [];
    List measures = [];
    List.generate(
        20, (index) => ingredients.add(json['strIngredient${index++}']));
    List.generate(20, (index) => measures.add(json['strMeasure${index++}']));

    return Meal(
      id: json['idMeal'],
      mealName: json['strMeal'],
      category: json['strCategory'],
      region: json['strArea'],
      instruction: json['strInstruction'],
      thumbnailUrl: json['strMealThumb'],
      tags: json['strTags'],
      ingredients: ingredients,
      measures: measures,
    );
  }
}
