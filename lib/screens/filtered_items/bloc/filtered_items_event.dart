part of 'filtered_items_bloc.dart';

@immutable
abstract class FilteredItemsEvent {}

class FilteredItemsSearch extends FilteredItemsEvent {
  final String searchTerm;

  FilteredItemsSearch(this.searchTerm);
}

class FilteredItemsBy extends FilteredItemsEvent {
  final Traits filterBy;

  FilteredItemsBy(this.filterBy);
}
