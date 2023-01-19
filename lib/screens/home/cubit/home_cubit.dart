import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whereisit/models/home_cubit_response.dart';
import 'package:whereisit/models/item_card_data.model.dart';
import 'package:whereisit/models/tiles_details_data.model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> fetchAll() async {
    var tilesList = [
      TilesDetailsData('Property', 1),
      TilesDetailsData('Room', 2),
      TilesDetailsData('Area', 3),
      TilesDetailsData('Item', 4),
    ];

    var oldestList = [
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

    emit(FetchAllLoading());

    var response = HomeCubitResponse({}, {}, {}, {}, {});

    if (tilesList.isEmpty) {
      response.success['tiles'] = false;
      response.error['tiles'] = 'Error';
      response.errorCode['tiles'] = "1";
      response.statusCode['tiles'] = 400;
      response.result['tiles'] = null;
    } else {
      response.success['tiles'] = true;
      response.error['tiles'] = '';
      response.errorCode['tiles'] = "0";
      response.statusCode['tiles'] = 200;
      response.result['tiles'] = tilesList;
    }

    if (oldestList.isEmpty) {
      response.success['item_card'] = false;
      response.error['item_card'] = 'Error';
      response.errorCode['item_card'] = "2";
      response.statusCode['item_card'] = 400;
      response.result['item_card'] = null;
    } else {
      response.success['item_card'] = true;
      response.error['item_card'] = '';
      response.errorCode['item_card'] = "0";
      response.statusCode['item_card'] = 200;
      response.result['item_card'] = oldestList;
    }

    emit(FetchAllComplete(response));
  }
}
