import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_meal_db/bloc/meal_bloc/meal_bloc.dart';
import 'package:the_meal_db/models/category.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context).settings.arguments as Category;
    // final size = MediaQuery.of(context).size;
    final texTheme = Theme.of(context).textTheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/');
        },
        child: Icon(Icons.arrow_back),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<MealBloc>(context)
                  .add(MealGetFilteredCategories(routeArgs.name, routeArgs));
            },
          )
        ],
        title: BlocBuilder<MealBloc, MealState>(
          builder: (context, state) {
            if (state is MealFilteredCategoriesLoaded) {
              return Text(state.categoryArgs.name);
            }
            return CircularProgressIndicator();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   height: size.height * 0.4,
            //   decoration: BoxDecoration(
            //     color: Colors.grey[200],
            //     image: DecorationImage(
            //       fit: BoxFit.fill,
            //       image: NetworkImage(routeArgs.thumbUrl),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'List All Meal',
                style: texTheme.headline4,
              ),
            ),
            BlocBuilder<MealBloc, MealState>(
              builder: (context, state) {
                if (state is MealFilteredCategoriesLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is MealFilteredCategoriesLoaded) {
                  return _showData(state);
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _showData(MealFilteredCategoriesLoaded state) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: state.filteredCategoryMeals.length,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          state.filteredCategoryMeals[index].thumbnailUrl),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  print(state.filteredCategoryMeals[index].id);
                  BlocProvider.of<MealBloc>(context).add(
                      MealDetailRecipe(state.filteredCategoryMeals[index].id));
                  Navigator.pushNamed(context, '/detail',
                      arguments: state.filteredCategoryMeals[index]);
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  child: Text(
                    state.filteredCategoryMeals[index].mealName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
