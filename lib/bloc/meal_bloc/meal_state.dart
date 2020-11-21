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

class MealFailure extends MealState {
  final String message;

  const MealFailure(this.message);
}
