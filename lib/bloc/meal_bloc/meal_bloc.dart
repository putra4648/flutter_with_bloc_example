import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
