import 'package:the_meal_db/models/category.dart';
import 'package:the_meal_db/models/meal.dart';

abstract class LocalDataRepositories {}

abstract class RemoteDataRepositories {
  Future<List<Meal>> getRecipesFromSearch(String query);
  Future<List<Meal>> getRandomRecipes();
  Future<List<Meal>> getDetailedRecipes(String id);
  Future<List<Category>> getCategories();
  Future<List<Meal>> getCategoryMeals(String cateog);
}
