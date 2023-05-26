part of 'location_search_bloc.dart';

@immutable
abstract class LocationSearchEvent {}

class LocationLoad extends LocationSearchEvent {}

class LocationSelected extends LocationSearchEvent {
  final LatLng location;

  LocationSelected(this.location);
}
