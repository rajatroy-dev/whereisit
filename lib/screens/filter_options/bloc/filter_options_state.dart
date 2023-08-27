part of 'filter_options_bloc.dart';

@immutable
sealed class FilterOptionsState {}

final class FilterOptionsInitial extends FilterOptionsState {}

class FilterOptionsLoadSuccess extends FilterOptionsState {
  final Map<String, dynamic> filterOptions;

  FilterOptionsLoadSuccess(this.filterOptions);
}

class FilterOptionsLoadPropertiesSuccess extends FilterOptionsState {
  final List<Property> filterOptions;

  FilterOptionsLoadPropertiesSuccess(this.filterOptions);
}

class FilterOptionsLoadPropertiesFailure extends FilterOptionsState {}

class FilterOptionsLoadFailure extends FilterOptionsState {}

class FilterOptionToggleSuccess extends FilterOptionsState {}

class FilterOptionToggleFailure extends FilterOptionsState {}
