import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

// part 'navigation_event.dart';
part 'navigation_state.dart';

enum Navigation { Home, Detail, Category }

class NavigationBloc extends Bloc<Navigation, NavigationState> {
  NavigationBloc() : super(NavigationToHome());

  @override
  Stream<NavigationState> mapEventToState(Navigation event) async* {
    switch (event) {
      case Navigation.Home:
        yield NavigationToHome();
        break;
      case Navigation.Detail:
        yield NavigationToDetail();
        break;
      case Navigation.Category:
        yield NavigationToCategory();
        break;
    }
  }
}
