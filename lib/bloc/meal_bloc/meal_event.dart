part of 'meal_bloc.dart';

@immutable
abstract class MealEvent {
  const MealEvent();
}

class MealEventSearch extends MealEvent {
  final String query;

  const MealEventSearch({@required this.query});
}

class MealGetRandomMeal extends MealEvent {}

class MealDetailRecipe extends MealEvent {
  final String id;

  const MealDetailRecipe(this.id);
}

class MealGetCategories extends MealEvent {}

class MealGetFilteredCategories extends MealEvent {
  final String category;

  MealGetFilteredCategories(this.category);
}
