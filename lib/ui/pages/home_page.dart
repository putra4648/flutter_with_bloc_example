import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_meal_db/bloc/meal_bloc/meal_bloc.dart';
import 'package:the_meal_db/bloc/navigation_bloc/navigation_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is NavigationToDetail) {
          Navigator.pushNamed(context, '/detail');
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.info),
        ),
        appBar: AppBar(
          title: Text('The Meal DB'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter recipes name',
                ),
                onSubmitted: (value) => BlocProvider.of<MealBloc>(context)
                    .add(MealEventSearch(query: value)),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[200],
                child: SingleChildScrollView(
                  child: BlocBuilder<MealBloc, MealState>(
                    builder: (context, state) {
                      if (state is MealInitial) {
                        return Center(
                          child: Text('Please Search'),
                        );
                      } else if (state is MealLoading) {
                        return Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      } else if (state is MealLoaded) {
                        return Column(
                          children: state.meals
                              .map((meal) => ListTile(
                                    onTap: () {
                                      BlocProvider.of<NavigationBloc>(context)
                                          .add(NavigationEvent.Detail);
                                    },
                                    leading: Image.network(
                                      meal.thumbnailUrl,
                                      width: 100,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(),
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(
                                      meal.mealName ?? 'No Data',
                                      style: meal.tags ??
                                          TextStyle(
                                              fontStyle: FontStyle.italic),
                                    ),
                                    subtitle: Text(
                                      meal.tags ?? 'No Data',
                                      style: meal.tags ??
                                          TextStyle(
                                              fontStyle: FontStyle.italic),
                                    ),
                                  ))
                              .toList(),
                        );
                      } else if (state is MealFailure) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
