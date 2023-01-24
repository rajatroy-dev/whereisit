part of 'filtered_items_bloc.dart';

@immutable
abstract class FilteredItemsState {}

class FilteredItemsInitial extends FilteredItemsState {}

class FilteredItemsLoading extends FilteredItemsState {}

class FilteredItemsSuccess extends FilteredItemsState {
  final List<CardData> filteredItems;

  FilteredItemsSuccess(this.filteredItems);
}

class FilteredItemsError extends FilteredItemsState {}
