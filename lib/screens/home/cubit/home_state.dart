part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class FetchAllLoading extends HomeInitial {}

class FetchAllComplete extends HomeInitial {
  final HomeCubitResponse response;

  FetchAllComplete(this.response);
}
