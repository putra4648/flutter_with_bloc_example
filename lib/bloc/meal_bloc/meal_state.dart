part of 'meal_bloc.dart';

@immutable
abstract class MealState {
  const MealState();
}

class MealInitial extends MealState {}

class MealLoading extends MealState {}

class MealLoaded extends MealState {
  final List<Meal> meals;

  const MealLoaded(this.meals);
}

class MealFilteredCategoriesLoading extends MealState {}

class MealFilteredCategoriesLoaded extends MealState {
  final Category categoryArgs;
  final List<Meal> filteredCategoryMeals;
  const MealFilteredCategoriesLoaded(
      {@required this.filteredCategoryMeals, this.categoryArgs});
}

class MealCategoriesLoading extends MealState {}

class MealCategoriesLoaded extends MealState {
  final List<Category> categories;

  const MealCategoriesLoaded(this.categories);
}

class MealDetailLoading extends MealState {}

class MealDetailLoaded extends MealState {
  final List<Meal> meals;

  const MealDetailLoaded(this.meals);
}

class MealFailure extends MealState {
  final String message;

  const MealFailure(this.message);
}
