part of 'search_items_bloc.dart';

@immutable
abstract class SearchItemsState {
  final CardData item;

  const SearchItemsState(this.item);
}

class SearchItemsInitial extends SearchItemsState {
  const SearchItemsInitial(CardData item) : super(item);
}

class SearchItemsLoading extends SearchItemsState {
  const SearchItemsLoading(CardData item) : super(item);
}

class SearchItemsTextFilterSuccess extends SearchItemsState {
  const SearchItemsTextFilterSuccess(CardData item) : super(item);
}

class SearchItemsTextFilterFailure extends SearchItemsState {
  const SearchItemsTextFilterFailure(CardData item) : super(item);
}
