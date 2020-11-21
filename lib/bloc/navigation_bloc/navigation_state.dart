part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState {
  const NavigationState();
}

class NavigationToHome extends NavigationState {}

class NavigationToDetail extends NavigationState {}
