import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whereisit/models/item_card_data.model.dart';
import 'package:whereisit/models/tiles_details_data.model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> fetchTilesDetails() async {
    var list = [
      TilesDetailsData('Property', 1),
      TilesDetailsData('Room', 2),
      TilesDetailsData('Area', 3),
      TilesDetailsData('Item', 4),
    ];

    emit(FetchFavoriteItemsLoading());

    if (list.isEmpty) {
      emit(FetchTilesDetailsFailure('Error'));
      return;
    }

    emit(FetchTilesDetailsSuccess(list));
  }

  Future<void> fetchOldestItems() async {
    var list = [
      ItemCardData(
        'https://picsum.photos/200',
        'A random picture',
        'A random location',
        5,
        ['abcdef', 'ghijkl'],
      ),
      ItemCardData(
        'https://picsum.photos/200',
        'A random picture',
        'A random location',
        5,
        ['abcdef', 'ghijkl'],
      ),
      ItemCardData(
        'https://picsum.photos/200',
        'A random picture',
        'A random location',
        5,
        ['abcdef', 'ghijkl'],
      ),
      ItemCardData(
        'https://picsum.photos/200',
        'A random picture',
        'A random location',
        5,
        ['abcdef', 'ghijkl'],
      ),
      ItemCardData(
        'https://picsum.photos/200',
        'A random picture',
        'A random location',
        5,
        ['abcdef', 'ghijkl'],
      ),
    ];

    emit(FetchOldestItemsLoading());

    if (list.isEmpty) {
      emit(FetchOldestItemsFailure('Error'));
      return;
    }

    emit(FetchOldestItemsSuccess(list));
  }
}
