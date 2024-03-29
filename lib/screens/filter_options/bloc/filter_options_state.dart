part of 'filter_options_bloc.dart';

@immutable
sealed class FilterOptionsState {}

final class FilterOptionsInitial extends FilterOptionsState {}

class FilterOptionsLoadSuccess extends FilterOptionsState {
  final Map<String, dynamic> filterOptions;

  FilterOptionsLoadSuccess(this.filterOptions);
}

class FilterOptionsLoadForFavoritesSuccess extends FilterOptionsState {
  final Map<String, dynamic> filterOptions;

  FilterOptionsLoadForFavoritesSuccess(this.filterOptions);
}

class FilterOptionsLoadTypeSuccess extends FilterOptionsState {
  final List<dynamic> filterOptions;

  FilterOptionsLoadTypeSuccess(this.filterOptions);
}

class FilterOptionsLoadTypeFailure extends FilterOptionsState {}

class FilterOptionsLoadFailure extends FilterOptionsState {}

class FilterOptionToggleSuccess extends FilterOptionsState {}

class FilterOptionToggleFailure extends FilterOptionsState {}
