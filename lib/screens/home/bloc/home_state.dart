part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeFetchTilesLoading extends HomeInitial {}

class HomeFetchOldestLoading extends HomeInitial {}

class HomeFetchLatestLoading extends HomeInitial {}

class HomeFetchFavoritesLoading extends HomeInitial {}

class HomeFetchMostTaggedLoading extends HomeInitial {}

class HomeFetchTilesSuccess extends HomeInitial {
  final HomeBlocResponse response;

  HomeFetchTilesSuccess(this.response);
}

class HomeFetchOldestSuccess extends HomeInitial {
  final HomeBlocResponse response;

  HomeFetchOldestSuccess(this.response);
}

class HomeFetchLatestSuccess extends HomeInitial {
  final HomeBlocResponse response;

  HomeFetchLatestSuccess(this.response);
}

class HomeFetchFavoritesSuccess extends HomeInitial {
  final HomeBlocResponse response;

  HomeFetchFavoritesSuccess(this.response);
}

class HomeFetchMostTaggedSuccess extends HomeInitial {
  final HomeBlocResponse response;

  HomeFetchMostTaggedSuccess(this.response);
}

class HomeFetchTilesFailure extends HomeInitial {
  final HomeBlocResponse response;

  HomeFetchTilesFailure(this.response);
}

class HomeFetchOldestFailure extends HomeInitial {
  final HomeBlocResponse response;

  HomeFetchOldestFailure(this.response);
}

class HomeFetchLatestFailure extends HomeInitial {
  final HomeBlocResponse response;

  HomeFetchLatestFailure(this.response);
}

class HomeFetchFavoritesFailure extends HomeInitial {
  final HomeBlocResponse response;

  HomeFetchFavoritesFailure(this.response);
}

class HomeFetchMostTaggedFailure extends HomeInitial {
  final HomeBlocResponse response;

  HomeFetchMostTaggedFailure(this.response);
}

class HomeFetchAllComplete extends HomeInitial {
  final HomeBlocResponse response;

  HomeFetchAllComplete(this.response);
}
