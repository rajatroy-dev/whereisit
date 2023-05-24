part of 'location_search_bloc.dart';

@immutable
abstract class LocationSearchEvent {}

class LocationSelected extends LocationSearchEvent {
  final String location;

  LocationSelected(this.location);
}
