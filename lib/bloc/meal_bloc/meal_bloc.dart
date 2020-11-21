import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:the_meal_db/models/category.dart';
import 'package:the_meal_db/models/meal.dart';
import 'package:the_meal_db/repositories/remote_data/repos_impl.dart';

part 'meal_event.dart';
part 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final RemoteDataRepositoriesImpl repositoriesImpl;
  MealBloc(this.repositoriesImpl) : super(MealInitial());

  @override
  Stream<MealState> mapEventToState(MealEvent event) async* {
    if (event is MealEventSearch) {
      yield* _mapEventSearchToState(event);
    }
    if (event is MealDetailRecipe) {
      yield* _mapEventDetailedRecipeToState(event);
    }
    if (event is MealGetRandomMeal) {
      yield* _mapEventRandomMealToState(event);
    }
    if (event is MealGetCategories) {
      yield* _mapEventCategoriesToState();
    }
    if (event is MealGetFilteredCategories) {
      yield* _mapEventFilteredCategoriesToState(event);
    }
  }

  Stream<MealState> _mapEventDetailedRecipeToState(
      MealDetailRecipe event) async* {
    try {
      yield MealDetailLoading();
      final detailedRecipe =
          await repositoriesImpl.getDetailedRecipes(event.id);
      yield MealDetailLoaded(detailedRecipe);
    } catch (e) {
      yield MealFailure(e.toString());
    }
  }

  Stream<MealState> _mapEventFilteredCategoriesToState(
      MealGetFilteredCategories event) async* {
    try {
      yield MealFilteredCategoriesLoading();
      final filteredCategories =
          await repositoriesImpl.getCategoryMeals(event.category);
      yield MealFilteredCategoriesLoaded(
          filteredCategoryMeals: filteredCategories,
          categoryArgs: event.categoryArgs);
    } catch (e) {
      yield MealFailure(e.toString());
    }
  }

  Stream<MealState> _mapEventCategoriesToState() async* {
    try {
      yield MealCategoriesLoading();
      final categories = await repositoriesImpl.getCategories();
      yield MealCategoriesLoaded(categories);
    } catch (e) {
      yield MealFailure(e.toString());
    }
  }

  Stream<MealState> _mapEventRandomMealToState(MealGetRandomMeal event) async* {
    try {
      yield MealLoading();
      final meals = await repositoriesImpl.getRandomRecipes();
      yield MealLoaded(meals);
    } catch (e) {
      yield MealFailure(e.toString());
    }
  }

  Stream<MealState> _mapEventSearchToState(MealEventSearch event) async* {
    try {
      yield MealLoading();
      final meals = await repositoriesImpl.getRecipesFromSearch(event.query);
      yield MealLoaded(meals);
    } catch (e) {
      yield MealFailure(e.toString());
    }
  }
}
