import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/meal_bloc/meal_bloc.dart';
import '../../models/meal.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<MealBloc>(context).add(MealGetCategories());
    super.initState();
  }

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
            child: BlocBuilder<MealBloc, MealState>(
              builder: (context, state) {
                if (state is MealInitial) {
                  return LinearProgressIndicator();
                }
                if (state is MealCategoriesLoaded) {
                  return ListView.builder(
                    itemCount: state.categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: OutlineButton(
                        onPressed: () {
                          BlocProvider.of<MealBloc>(context).add(
                            MealGetFilteredCategories(
                                state.categories[index].name),
                          );
                          Navigator.pushReplacementNamed(context, '/category',
                              arguments: state.categories[index]);
                        },
                        child: Text(state.categories[index].name),
                      ),
                    ),
                  );
                }
                if (state is MealFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return Container(
                  child: Text('error'),
                );
              },
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
                    return _showData(state.meals);
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

  Widget _showData(List<Meal> meals) {
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
