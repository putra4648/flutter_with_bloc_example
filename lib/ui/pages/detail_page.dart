import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_meal_db/bloc/meal_bloc/meal_bloc.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
          child: Icon(Icons.arrow_back),
        ),
        body: BlocBuilder<MealBloc, MealState>(
          builder: (context, state) {
            if (state is MealLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is MealLoaded) {
              return CustomScrollView(
                slivers: [
                  _showAppBar(state, size),
                  _showLabel('Instructions', context),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(state.meals[0].instruction ?? ''),
                    ),
                  ),
                  _showLabel('Ingredients', context),
                  _showDetailRecipes(size, state),
                ],
              );
            }

            if (state is MealDetailLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is MealDetailLoaded) {
              return CustomScrollView(
                slivers: [
                  _showAppBar(state, size),
                  _showLabel('Instructions', context),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(state.meals[0].instruction ?? ''),
                    ),
                  ),
                  _showLabel('Ingredients', context),
                  _showDetailRecipes(size, state),
                ],
              );
            }
            return Container();
          },
        ));
  }

  Widget _showAppBar(MealState state, Size size) {
    if (state is MealLoaded) {
      return SliverAppBar(
        snap: true,
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: Image.network(
            state.meals[0].thumbnailUrl,
            fit: BoxFit.fill,
          ),
          title: Text(
            state.meals[0].mealName,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        expandedHeight: size.height * 0.4,
      );
    }
    if (state is MealDetailLoaded) {
      return SliverAppBar(
        snap: true,
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          background: Image.network(
            state.meals[0].thumbnailUrl,
            fit: BoxFit.fill,
          ),
          title: Text(
            state.meals[0].mealName,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        expandedHeight: size.height * 0.4,
      );
    }
    return SliverAppBar();
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

  Widget _showDetailRecipes(Size size, MealState state) {
    if (state is MealLoaded) {
      return SliverToBoxAdapter(
        child: LimitedBox(
          maxHeight: size.height * 0.3,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.meals[0].ingredients.length,
            itemBuilder: (context, index) {
              final recipesFiltered = state.meals[0].ingredients
                  .where((element) => element != null && element != '')
                  .toList();
              final measuresFiltered = state.meals[0].measures
                  .where((element) => element != null && element != '')
                  .toList();
              return Card(
                margin: const EdgeInsets.all(10),
                child: Container(
                  width: size.width * 0.4,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://www.themealdb.com/images/ingredients/${recipesFiltered[index]}-Small.png'),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                        '${recipesFiltered[index]} ${measuresFiltered[index]}'),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
    if (state is MealDetailLoaded) {
      final recipesFiltered = state.meals[0].ingredients
          .where((element) => element != null && element != '')
          .toList();
      final measuresFiltered = state.meals[0].measures
          .where((element) => element != null && element != '')
          .toList();
      return SliverToBoxAdapter(
        child: LimitedBox(
          maxHeight: size.height * 0.3,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recipesFiltered.length,
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
                          'https://www.themealdb.com/images/ingredients/${recipesFiltered[index]}-Small.png'),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                        '${recipesFiltered[index]} ${measuresFiltered[index]}'),
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return SliverToBoxAdapter(child: Container());
    }
  }
}
