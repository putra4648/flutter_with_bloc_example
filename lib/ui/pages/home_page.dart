import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/meal_bloc/meal_bloc.dart';
import '../../bloc/navigation_bloc/navigation_bloc.dart';
import '../../models/meal.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Meal mealArgs;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is NavigationToDetail) {
          Navigator.pushReplacementNamed(context, '/detail',
              arguments: mealArgs);
        }
      },
      child: Scaffold(
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
                  hintText: 'Cari nama resep',
                ),
                onSubmitted: (value) => BlocProvider.of<MealBloc>(context)
                    .add(MealEventSearch(query: value)),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[200],
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
                      return _showData(state.meals);
                    } else if (state is MealFailure) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _showData(List<Meal> meals) {
    return SingleChildScrollView(
      child: Column(
        children: meals
            .map((meal) => ListTile(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(Navigation.Detail);
                    mealArgs = meal;
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
