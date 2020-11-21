import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_meal_db/repositories/remote_data/repos_impl.dart';
import 'package:the_meal_db/ui/pages/detail_page.dart';

import 'bloc/meal_bloc/meal_bloc.dart';
import 'bloc/navigation_bloc/navigation_bloc.dart';
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
        BlocProvider(
          create: (context) => NavigationBloc(),
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
      title: 'The Meal DB',
      routes: {
        '/': (context) => HomePage(),
        '/detail': (context) => DetailPage(),
      },
      initialRoute: '/',
      // home: BlocBuilder<NavigationBloc, NavigationState>(
      //   builder: (_, state) =>
      //       state is NavigationToHome ? HomePage() : DetailPage(),
      // ),
    );
  }
}
