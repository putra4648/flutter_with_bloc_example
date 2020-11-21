import 'dart:convert';

import 'package:the_meal_db/models/meal.dart';
import 'package:the_meal_db/repositories/repositories.dart';
import 'package:http/http.dart' as http;
import 'base/url_base.dart';

class RemoteDataRepositoriesImpl implements RemoteDataRepositories {
  final client = http.Client();

  @override
  Future<List<Meal>> getRecipesFromSearch(String query) async {
    List result;

    final response = await client.get(
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
  Future<List<Meal>> getRecipesDetailed(int id) async {
    return [];
  }

  @override
  Future<List<Meal>> getRandomRecipes(int id) async {
    return [];
  }
}
