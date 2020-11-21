import 'dart:convert';

import 'package:the_meal_db/models/category.dart';
import 'package:the_meal_db/models/meal.dart';
import 'package:the_meal_db/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'base/url_base.dart';

class RemoteDataRepositoriesImpl implements RemoteDataRepositories {
  final _client = http.Client();

  @override
  Future<List<Meal>> getRecipesFromSearch(String query) async {
    List result;

    final response = await _client.get(
        BaseUri.instance.searchUri.replaceAll('<?>', query),
        headers: {'Content-Type': 'application/json'});
    // print();
    if (response.statusCode == 200) {
      result = jsonDecode(response.body)['meals'];
    } else {
      result = [];
    }

    return result.map((e) => Meal.fromJson(e)).toList();
  }

  @override
  Future<List<Meal>> getRandomRecipes() async {
    List result;
    final response = await _client.get(BaseUri.instance.randomUri);
    if (response.statusCode == 200) {
      result = jsonDecode(response.body)['meals'];
    }
    return result.map((e) => Meal.fromJson(e)).toList();
  }

  @override
  Future<List<Category>> getCategories() async {
    List result;
    final response = await _client.get(BaseUri.instance.categoryUri);
    if (response.statusCode == 200) {
      result = jsonDecode(response.body)['categories'];
    }
    return result.map((e) => Category.fromJson(e)).toList();
  }

  @override
  Future<List<Meal>> getCategoryMeals(String category) async {
    List result;
    final response = await _client
        .get(BaseUri.instance.filterCategoryUri.replaceAll('<?>', category));
    if (response.statusCode == 200) {
      result = jsonDecode(response.body)['meals'];
    }
    return result.map((e) => Meal.fromJson(e)).toList();
  }

  @override
  Future<List<Meal>> getDetailedRecipes(String id) async {
    List result;
    final response = await _client
        .get(BaseUri.instance.recipesDetailUri.replaceAll('<?>', id));
    if (response.statusCode == 200) {
      result = jsonDecode(response.body)['meals'];
    }
    return result.map((e) => Meal.fromJson(e)).toList();
  }
}
