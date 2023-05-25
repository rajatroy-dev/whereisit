part of 'location_search_bloc.dart';

@immutable
abstract class LocationSearchState {}

class LocationSearchInitial extends LocationSearchState {}

class LocationLoadSuccess extends LocationSearchState {
  final String coordinates;

  LocationLoadSuccess(this.coordinates);
}

class LocationSelectionSuccess extends LocationSearchState {
  final Map<String, String> coordinates;

  LocationSelectionSuccess(this.coordinates);
}
