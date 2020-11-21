part of 'meal_bloc.dart';

@immutable
abstract class MealEvent {
  const MealEvent();
}

class MealEventSearch extends MealEvent {
  final String query;

  const MealEventSearch({@required this.query});

  @override
  String toString() {
    return 'Meal search name: $query';
  }
}
