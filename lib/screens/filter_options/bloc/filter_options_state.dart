part of 'filter_options_bloc.dart';

@immutable
sealed class FilterOptionsState {}

final class FilterOptionsInitial extends FilterOptionsState {}

class FilterOptionsLoadSuccess extends FilterOptionsState {
  final Map<String, dynamic> filterOptions;

  FilterOptionsLoadSuccess(this.filterOptions);
}
