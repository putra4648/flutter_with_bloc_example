import 'package:flutter/material.dart';

import '../../models/meal.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Meal;
    final filteredIngredients = routeArgs.ingredients
        .where((element) => element != null && element != '')
        .toList();
    final filteredMeasures = routeArgs.measures
        .where((element) => element != null && element != '')
        .toList();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/');
        },
        child: Icon(Icons.arrow_back),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Image.network(
                routeArgs.thumbnailUrl,
                fit: BoxFit.fill,
              ),
              title: Text(
                routeArgs.mealName,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            expandedHeight: size.height * 0.4,
          ),
          _showLabel('Ingredients', context),
          _showDetailRecipes(size, filteredIngredients, filteredMeasures),
        ],
      ),
    );
  }

  Widget _showLabel(String name, BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          name,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }

  Widget _showDetailRecipes(Size size, List ingredients, List measures) {
    return SliverToBoxAdapter(
      child: LimitedBox(
        maxHeight: size.height * 0.3,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: ingredients.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(10),
              child: Container(
                width: size.width * 0.4,
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://www.themealdb.com/images/ingredients/${ingredients[index]}-Small.png'),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text('${ingredients[index]} ${measures[index]}'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
