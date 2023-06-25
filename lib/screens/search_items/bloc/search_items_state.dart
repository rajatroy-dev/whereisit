part of 'search_items_bloc.dart';

@immutable
abstract class SearchItemsState {}

class SearchItemsInitial extends SearchItemsState {}

class SearchItemsLoading extends SearchItemsState {}

class SearchItemsLoadSuccess extends SearchItemsState {
  final List<CardData> item;

  SearchItemsLoadSuccess(this.item);
}

class SearchItemsTextFilterSuccess extends SearchItemsState {
  final List<CardData> item;

  SearchItemsTextFilterSuccess(this.item);
}

class SearchItemsTextFilterFailure extends SearchItemsState {
  final String errorMsg;

  SearchItemsTextFilterFailure(this.errorMsg);
}
