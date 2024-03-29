part of 'filtered_items_bloc.dart';

@immutable
abstract class FilteredItemsState {}

class FilteredItemsInitial extends FilteredItemsState {}

class FilteredItemsLoading extends FilteredItemsState {}

class FilteredItemsSuccess extends FilteredItemsState {
  final Map<String, dynamic> filteredItems;

  FilteredItemsSuccess(this.filteredItems);
}

class FilteredItemsFailure extends FilteredItemsState {
  final String errorMessage;

  FilteredItemsFailure(this.errorMessage);
}
