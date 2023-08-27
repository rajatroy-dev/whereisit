part of 'filter_options_bloc.dart';

@immutable
sealed class FilterOptionsEvent {}

class FilterOptionsLoad extends FilterOptionsEvent {}

class FilterOptionsLoadProperties extends FilterOptionsEvent {
  final List<int> propertyIds;

  FilterOptionsLoadProperties(this.propertyIds);
}

class FilterOptionsToggle extends FilterOptionsEvent {
  final AvailableFilters availableFilters;
  final int id;
  final bool state;

  FilterOptionsToggle(
    this.availableFilters,
    this.id,
    this.state,
  );
}
