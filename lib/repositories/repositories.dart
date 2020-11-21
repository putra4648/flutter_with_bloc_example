import 'package:the_meal_db/models/meal.dart';

abstract class LocalDataRepositories {}

abstract class RemoteDataRepositories {
  Future<List<Meal>> getRecipesFromSearch(String query);
  Future<List<Meal>> getRecipesDetailed(int id);
  Future<List<Meal>> getRandomRecipes(int id);
}
