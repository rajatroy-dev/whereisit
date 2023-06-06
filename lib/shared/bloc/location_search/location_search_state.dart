part of 'location_search_bloc.dart';

@immutable
abstract class LocationSearchState {}

class LocationSearchInitial extends LocationSearchState {}

class LocationSearchIgnoreSuccess extends LocationSearchState {
  final LatLng location;

  LocationSearchIgnoreSuccess(this.location);
}

class LocationLoadSuccess extends LocationSearchState {
  final LatLng coordinates;

  LocationLoadSuccess(this.coordinates);
}

class LocationSelectionSuccess extends LocationSearchState {
  final LatLng coordinates;

  LocationSelectionSuccess(this.coordinates);
}
