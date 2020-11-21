part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState {}

class NavigationToHome extends NavigationState {}

class NavigationToDetail extends NavigationState {}
