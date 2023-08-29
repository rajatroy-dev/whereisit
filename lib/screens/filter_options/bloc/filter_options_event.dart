part of 'filter_options_bloc.dart';

@immutable
sealed class FilterOptionsEvent {}

class FilterOptionsLoad extends FilterOptionsEvent {}

class FilterOptionsLoadType extends FilterOptionsEvent {
  final AvailableFilters filterType;
  final List<int> ids;

  FilterOptionsLoadType(this.filterType, this.ids);
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
