import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'navigation_state.dart';

enum NavigationEvent { Home, Detail }

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationToHome());

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    switch (event) {
      case NavigationEvent.Home:
        yield NavigationToHome();
        break;

      case NavigationEvent.Detail:
        yield NavigationToDetail();
        break;
    }
  }
}
