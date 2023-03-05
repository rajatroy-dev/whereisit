part of 'location_search_bloc.dart';

@immutable
abstract class LocationSearchState {}

class LocationSearchInitial extends LocationSearchState {}

class LocationSearchSuccess extends LocationSearchState {}

class LocationSearchFailure extends LocationSearchState {
  final String errorMessage;

  LocationSearchFailure(this.errorMessage);
}
