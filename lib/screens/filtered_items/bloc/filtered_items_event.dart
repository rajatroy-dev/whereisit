part of 'filtered_items_bloc.dart';

@immutable
abstract class FilteredItemsEvent {}

class FilteredItemsClear extends FilteredItemsEvent {}

class FilteredItemsSearch extends FilteredItemsEvent {
  final String searchTerm;

  FilteredItemsSearch(this.searchTerm);
}

class FilteredItemsBy extends FilteredItemsEvent {
  final Traits filterBy;

  FilteredItemsBy(this.filterBy);
}

class FilteredItemsSort extends FilteredItemsEvent {
  final Chronology sortBy;

  FilteredItemsSort(this.sortBy);
}
