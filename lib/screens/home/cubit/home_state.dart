part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class FetchTilesDetailsLoading extends HomeInitial {}

class FetchTilesDetailsSuccess extends HomeInitial {
  final List<TilesDetailsData> tilesDetails;

  FetchTilesDetailsSuccess(this.tilesDetails);
}

class FetchTilesDetailsFailure extends HomeInitial {
  final String message;

  FetchTilesDetailsFailure(this.message);
}

class FetchOldestItemsLoading extends HomeInitial {}

class FetchOldestItemsSuccess extends HomeInitial {
  final List<ItemCardData> itemsList;

  FetchOldestItemsSuccess(this.itemsList);
}

class FetchOldestItemsFailure extends HomeInitial {
  final String message;

  FetchOldestItemsFailure(this.message);
}

class FetchLatestItemsLoading extends HomeInitial {}

class FetchLatestItemsSuccess extends HomeInitial {}

class FetchLatestItemsFailure extends HomeInitial {
  final String message;

  FetchLatestItemsFailure(this.message);
}

class FetchFavoriteItemsLoading extends HomeInitial {}

class FetchFavoriteItemsSuccess extends HomeInitial {}

class FetchFavoriteItemsFailure extends HomeInitial {
  final String message;

  FetchFavoriteItemsFailure(this.message);
}

class FetchItemsWithMostUsedTagLoading extends HomeInitial {}

class FetchItemsWithMostUsedTagSuccess extends HomeInitial {}

class FetchItemsWithMostUsedTagFailure extends HomeInitial {
  final String message;

  FetchItemsWithMostUsedTagFailure(this.message);
}
