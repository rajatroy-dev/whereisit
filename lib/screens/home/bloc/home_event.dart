part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeFetchTiles extends HomeEvent {}

class HomeFetchOldest extends HomeEvent {}

class HomeFetchLatest extends HomeEvent {}

class HomeFetchFavorites extends HomeEvent {}

class HomeFetchMostTagged extends HomeEvent {}
