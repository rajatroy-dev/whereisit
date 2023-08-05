part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class FetchTilesListLoading extends HomeInitial {}

class FetchOldestItemsLoading extends HomeInitial {}

class FetchLatestItemsLoading extends HomeInitial {}

class FetchFavoritesListLoading extends HomeInitial {}

class FetchMostTaggedItemsLoading extends HomeInitial {}

class FetchTilesListSuccess extends HomeInitial {
  final HomeCubitResponse response;

  FetchTilesListSuccess(this.response);
}

class FetchOldestItemsSuccess extends HomeInitial {
  final HomeCubitResponse response;

  FetchOldestItemsSuccess(this.response);
}

class FetchLatestItemsSuccess extends HomeInitial {
  final HomeCubitResponse response;

  FetchLatestItemsSuccess(this.response);
}

class FetchFavoritesListSuccess extends HomeInitial {
  final HomeCubitResponse response;

  FetchFavoritesListSuccess(this.response);
}

class FetchMostTaggedListSuccess extends HomeInitial {
  final HomeCubitResponse response;

  FetchMostTaggedListSuccess(this.response);
}

class FetchOldestItemsFailure extends HomeInitial {
  final HomeCubitResponse response;

  FetchOldestItemsFailure(this.response);
}

class FetchLatestItemsFailure extends HomeInitial {
  final HomeCubitResponse response;

  FetchLatestItemsFailure(this.response);
}

class FetchFavoritesListFailure extends HomeInitial {
  final HomeCubitResponse response;

  FetchFavoritesListFailure(this.response);
}

class FetchMostTaggedListFailure extends HomeInitial {
  final HomeCubitResponse response;

  FetchMostTaggedListFailure(this.response);
}

class FetchAllComplete extends HomeInitial {
  final HomeCubitResponse response;

  FetchAllComplete(this.response);
}
