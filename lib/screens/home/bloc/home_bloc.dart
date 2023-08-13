import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whereisit/data/repository/item_repository.dart';
import 'package:whereisit/data/repository/location_repository.dart';
import 'package:whereisit/data/repository/property_repository.dart';
import 'package:whereisit/data/repository/room_repository.dart';
import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/models/tiles_details_data.model.dart';
import 'package:whereisit/shared/enums/items_type.enum.dart';
import 'package:whereisit/shared/intents/home_cubit_response.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final propertyRepo = PropertyRepository();
  final roomRepo = RoomRepository();
  final locationRepo = LocationRepository();
  final itemRepo = ItemRepository();

  HomeBloc() : super(HomeInitial()) {
    var tilesList = <TilesDetailsData>[];

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
    var mostTaggedList = oldestList;
    var response = HomeBlocResponse({}, {}, {}, {}, {});

    on<HomeFetchTiles>((event, emit) async {
      emit(HomeFetchTilesLoading());

      try {
        var totalProperties = await propertyRepo.getTotalProperties();
        var totalRooms = await roomRepo.getTotalRooms();
        var totalLocations = await locationRepo.getTotalLocations();
        var totalItems = await itemRepo.getTotalItems();

        tilesList = [
          TilesDetailsData('Property', totalProperties),
          TilesDetailsData('Area', totalLocations),
          TilesDetailsData('Room', totalRooms),
          TilesDetailsData('Item', totalItems),
        ];

        response.success[ItemsType.tiles] = true;
        response.error[ItemsType.tiles] = '';
        response.errorCode[ItemsType.tiles] = "0";
        response.statusCode[ItemsType.tiles] = 200;
        response.result[ItemsType.tiles] = tilesList;

        emit(HomeFetchTilesSuccess(response));
      } catch (e) {
        response.success[ItemsType.tiles] = false;
        response.error[ItemsType.tiles] = 'Error while loading tiles!';
        response.errorCode[ItemsType.tiles] = "1";
        response.statusCode[ItemsType.tiles] = 500;
        response.result[ItemsType.tiles] = null;

        emit(HomeFetchTilesFailure(response));
      }
    });

    on<HomeFetchFavorites>((event, emit) async {
      emit(HomeFetchFavoritesLoading());

      try {
        var favorites = await itemRepo.findFavoriteItems();

        response.success[ItemsType.favorite] = true;
        response.error[ItemsType.favorite] = '';
        response.errorCode[ItemsType.favorite] = "0";
        response.statusCode[ItemsType.favorite] = 200;
        response.result[ItemsType.favorite] = favorites;
        emit(HomeFetchFavoritesSuccess(response));
      } catch (e) {
        response.success[ItemsType.favorite] = false;
        response.error[ItemsType.favorite] =
            'Error while loading list of favorites!';
        response.errorCode[ItemsType.favorite] = "4";
        response.statusCode[ItemsType.favorite] = 400;
        response.result[ItemsType.favorite] = null;
        emit(HomeFetchFavoritesFailure(response));
      }
    });

    on<HomeFetchOldest>((event, emit) {
      emit(HomeFetchOldestLoading());

      var response = HomeBlocResponse({}, {}, {}, {}, {});
      if (oldestList.isEmpty) {
        response.success[ItemsType.oldest] = false;
        response.error[ItemsType.oldest] =
            'Error while loading list of oldest items!';
        response.errorCode[ItemsType.oldest] = "2";
        response.statusCode[ItemsType.oldest] = 400;
        response.result[ItemsType.oldest] = null;
        emit(HomeFetchOldestFailure(response));
      } else {
        response.success[ItemsType.oldest] = true;
        response.error[ItemsType.oldest] = '';
        response.errorCode[ItemsType.oldest] = "0";
        response.statusCode[ItemsType.oldest] = 200;
        response.result[ItemsType.oldest] = oldestList;
        emit(HomeFetchOldestSuccess(response));
      }
    });

    on<HomeFetchLatest>((event, emit) {
      emit(HomeFetchLatestLoading());

      var response = HomeBlocResponse({}, {}, {}, {}, {});
      if (latestList.isEmpty) {
        response.success[ItemsType.latest] = false;
        response.error[ItemsType.latest] =
            'Error while loading list of latest items!';
        response.errorCode[ItemsType.latest] = "3";
        response.statusCode[ItemsType.latest] = 400;
        response.result[ItemsType.latest] = null;
        emit(HomeFetchLatestFailure(response));
      } else {
        response.success[ItemsType.latest] = true;
        response.error[ItemsType.latest] = '';
        response.errorCode[ItemsType.latest] = "0";
        response.statusCode[ItemsType.latest] = 200;
        response.result[ItemsType.latest] = oldestList;
        emit(HomeFetchLatestSuccess(response));
      }
    });

    on<HomeFetchMostTagged>((event, emit) {
      emit(HomeFetchMostTaggedLoading());

      var response = HomeBlocResponse({}, {}, {}, {}, {});
      if (mostTaggedList.isEmpty) {
        response.success[ItemsType.mostTagged] = false;
        response.error[ItemsType.mostTagged] =
            'Error while loading list of most tagged items!';
        response.errorCode[ItemsType.mostTagged] = "5";
        response.statusCode[ItemsType.mostTagged] = 400;
        response.result[ItemsType.mostTagged] = null;
        emit(HomeFetchMostTaggedFailure(response));
      } else {
        response.success[ItemsType.mostTagged] = true;
        response.error[ItemsType.mostTagged] = '';
        response.errorCode[ItemsType.mostTagged] = "0";
        response.statusCode[ItemsType.mostTagged] = 200;
        response.result[ItemsType.mostTagged] = mostTaggedList;
        emit(HomeFetchMostTaggedSuccess(response));
      }
    });
  }
}
