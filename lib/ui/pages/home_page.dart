import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_meal_db/models/category.dart';

import '../../bloc/meal_bloc/meal_bloc.dart';
import '../../models/meal.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Pesan'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      'Terima kasih telah mencoba clone aplikasi saya di repo :)'),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                      'Aplikasi ini hanyalah tutorial sederhana bagaimana menggunakan flutter_bloc'),
                ],
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                )
              ],
            ),
          );
        },
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
                hintText: 'Search your recipes',
              ),
              onSubmitted: (value) => BlocProvider.of<MealBloc>(context)
                  .add(MealEventSearch(query: value)),
            ),
          ),
          LimitedBox(
            maxHeight: size.height * 0.05,
            child: ListView.builder(
              itemCount: Category.categoriesName.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: OutlineButton(
                  onPressed: () {
                    BlocProvider.of<MealBloc>(context).add(
                      MealGetFilteredCategories(
                        Category.categoriesName[index],
                        Category(
                          id: null,
                          name: Category.categoriesName[index],
                          thumbUrl: null,
                          description: null,
                        ),
                      ),
                    );
                    Navigator.pushReplacementNamed(context, '/category');
                  },
                  child: Text(Category.categoriesName[index]),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlineButton(
                  onPressed: () {
                    BlocProvider.of<MealBloc>(context).add(MealGetRandomMeal());
                  },
                  child: Text('Search Randomly'),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: BlocBuilder<MealBloc, MealState>(
                builder: (context, state) {
                  if (state is MealLoading) {
                    return Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }
                  if (state is MealLoaded) {
                    return _showData(state.meals, context);
                  }
                  if (state is MealFailure) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return Container();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _showData(List<Meal> meals, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: meals
            .map((meal) => ListTile(
                  onTap: () {
                    // BlocProvider.of<MealBloc>(context).add(Meal);
                    Navigator.pushReplacementNamed(context, '/detail');
                  },
                  leading: Image.network(
                    meal.thumbnailUrl,
                    width: 100,
                    errorBuilder: (context, error, stackTrace) => Container(),
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    meal.mealName ?? 'No Data',
                  ),
                  subtitle: Text(
                    meal.tags ?? 'No Data',
                  ),
                  isThreeLine: true,
                ))
            .toList(),
      ),
    );
  }
}
