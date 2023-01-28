import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whereisit/models/card_data.model.dart';

import 'package:whereisit/models/home_cubit_response.dart';
import 'package:whereisit/models/tiles_details_data.model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> fetchAll() async {
    var tilesList = [
      TilesDetailsData('Property', 1),
      TilesDetailsData('Area', 3),
      TilesDetailsData('Room', 2),
      TilesDetailsData('Item', 4),
    ];

    var oldestList = [
      CardData(
        id: "6",
        imageSrc: 'https://picsum.photos/115',
        title: "A random picture 6",
        location: "A random location 6",
        qty: 1,
        tags: ["tag3", "tag4"],
        createdAt: "2022-07-12",
      ),
      CardData(
        id: "7",
        imageSrc: 'https://picsum.photos/115',
        title: "A random picture 7",
        location: "A random location 7",
        qty: 2,
        tags: ["tag7", "tag8"],
        createdAt: "2022-06-06",
      ),
      CardData(
        id: "8",
        imageSrc: 'https://picsum.photos/115',
        title: "A random picture 8",
        location: "A random location 8",
        qty: 3,
        tags: ["tag9", "tag10"],
        createdAt: "2022-05-19",
      ),
      CardData(
        id: "9",
        imageSrc: 'https://picsum.photos/115',
        title: "A random picture 9",
        location: "A random location 9",
        qty: 4,
        tags: ["tag7", "tag10"],
        createdAt: "2022-04-17",
        isFavorite: true,
      ),
      CardData(
        id: "10",
        imageSrc: 'https://picsum.photos/115',
        title: "A random picture 10",
        location: "A random location 10",
        qty: 10,
        tags: ["tag8", "tag9"],
        createdAt: "2022-03-20",
      ),
    ];

    var latestList = oldestList;
    var favoriteList = oldestList;
    var mostTaggedList = oldestList;

    emit(FetchAllLoading());

    var response = HomeCubitResponse({}, {}, {}, {}, {});

    if (tilesList.isEmpty) {
      response.success['tiles'] = false;
      response.error['tiles'] = 'Error while loading Tiles!';
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
      response.success['oldest_items'] = false;
      response.error['oldest_items'] =
          'Error while loading list of oldest items!';
      response.errorCode['oldest_items'] = "2";
      response.statusCode['oldest_items'] = 400;
      response.result['oldest_items'] = null;
    } else {
      response.success['oldest_items'] = true;
      response.error['oldest_items'] = '';
      response.errorCode['oldest_items'] = "0";
      response.statusCode['oldest_items'] = 200;
      response.result['oldest_items'] = oldestList;
    }

    if (latestList.isEmpty) {
      response.success['latest_items'] = false;
      response.error['latest_items'] =
          'Error while loading list of latest items!';
      response.errorCode['latest_items'] = "3";
      response.statusCode['latest_items'] = 400;
      response.result['latest_items'] = null;
    } else {
      response.success['latest_items'] = true;
      response.error['latest_items'] = '';
      response.errorCode['latest_items'] = "0";
      response.statusCode['latest_items'] = 200;
      response.result['latest_items'] = oldestList;
    }

    if (favoriteList.isEmpty) {
      response.success['favorites'] = false;
      response.error['favorites'] = 'Error while loading list of favorites!';
      response.errorCode['favorites'] = "4";
      response.statusCode['favorites'] = 400;
      response.result['favorites'] = null;
    } else {
      response.success['favorites'] = true;
      response.error['favorites'] = '';
      response.errorCode['favorites'] = "0";
      response.statusCode['favorites'] = 200;
      response.result['favorites'] = favoriteList;
    }

    if (mostTaggedList.isEmpty) {
      response.success['most_tagged'] = false;
      response.error['most_tagged'] =
          'Error while loading list of most tagged items!';
      response.errorCode['most_tagged'] = "5";
      response.statusCode['most_tagged'] = 400;
      response.result['most_tagged'] = null;
    } else {
      response.success['most_tagged'] = true;
      response.error['most_tagged'] = '';
      response.errorCode['most_tagged'] = "0";
      response.statusCode['most_tagged'] = 200;
      response.result['most_tagged'] = mostTaggedList;
    }

    emit(FetchAllComplete(response));
  }
}
