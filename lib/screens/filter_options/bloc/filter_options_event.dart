part of 'filter_options_bloc.dart';

@immutable
sealed class FilterOptionsEvent {}

class FilterOptionsLoad extends FilterOptionsEvent {}

class FilterOptionsToggle extends FilterOptionsEvent {
  final AvailableFilters availableFilters;
  final int id;

  FilterOptionsToggle(
    this.availableFilters,
    this.id,
  );
}
