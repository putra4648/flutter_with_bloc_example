import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_meal_db/ui/pages/category_page.dart';

import 'bloc/meal_bloc/meal_bloc.dart';
import 'repositories/remote_data/repos_impl.dart';
import 'ui/pages/detail_page.dart';
import 'ui/pages/home_page.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MealBloc(
            RemoteDataRepositoriesImpl(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.green,
      ),
      title: 'The Meal DB',
      routes: {
        '/': (context) => HomePage(),
        '/detail': (context) => DetailPage(),
        '/category': (context) => CategoryPage(),
      },
      initialRoute: '/',
    );
  }
}
