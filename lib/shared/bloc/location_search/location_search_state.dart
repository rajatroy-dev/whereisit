part of 'location_search_bloc.dart';

@immutable
abstract class LocationSearchState {}

class LocationSearchInitial extends LocationSearchState {}

class LocationSearchSuccess extends LocationSearchState {
  final List<String> locationList;

  LocationSearchSuccess(this.locationList);
}

class LocationSearchFailure extends LocationSearchState {
  final String errorMessage;

  LocationSearchFailure(this.errorMessage);
}

class LocationSelectionSuccess extends LocationSearchState {
  final Map<String, String> addressAndCoordinates;

  LocationSelectionSuccess(this.addressAndCoordinates);
}
