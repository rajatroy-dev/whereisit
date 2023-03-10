part of 'location_search_bloc.dart';

@immutable
abstract class LocationSearchEvent {}

class LocationSearchByKeyword extends LocationSearchEvent {
  final String location;

  LocationSearchByKeyword(this.location);
}

class LocationSearchClear extends LocationSearchEvent {}

class LocationSelected extends LocationSearchEvent {
  final String location;

  LocationSelected(this.location);
}
