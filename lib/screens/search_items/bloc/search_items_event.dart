part of 'search_items_bloc.dart';

@immutable
abstract class SearchItemsEvent {}

class SearchItemsTextFilter extends SearchItemsEvent {
  final String searchString;

  SearchItemsTextFilter(this.searchString);
}
