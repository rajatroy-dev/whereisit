import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whereisit/data/repository/item_repository.dart';
import 'package:whereisit/data/repository/location_repository.dart';
import 'package:whereisit/data/repository/property_repository.dart';
import 'package:whereisit/data/repository/room_repository.dart';
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

    on<HomeFetchTiles>((event, emit) async {
      emit(HomeFetchTilesLoading());
      var response = HomeBlocResponse({}, {}, {}, {}, {});

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
      var response = HomeBlocResponse({}, {}, {}, {}, {});

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

    on<HomeFetchOldest>((event, emit) async {
      emit(HomeFetchOldestLoading());
      var response = HomeBlocResponse({}, {}, {}, {}, {});

      try {
        var oldestItems = await itemRepo.findOldestItems();

        response.success[ItemsType.oldest] = true;
        response.error[ItemsType.oldest] = '';
        response.errorCode[ItemsType.oldest] = "0";
        response.statusCode[ItemsType.oldest] = 200;
        response.result[ItemsType.oldest] = oldestItems;
        emit(HomeFetchOldestSuccess(response));
      } catch (e) {
        response.success[ItemsType.oldest] = false;
        response.error[ItemsType.oldest] =
            'Error while loading list of oldest items!';
        response.errorCode[ItemsType.oldest] = "2";
        response.statusCode[ItemsType.oldest] = 400;
        response.result[ItemsType.oldest] = null;
        emit(HomeFetchOldestFailure(response));
      }
    });

    on<HomeFetchLatest>((event, emit) async {
      emit(HomeFetchLatestLoading());
      var response = HomeBlocResponse({}, {}, {}, {}, {});

      try {
        var latestItems = await itemRepo.findLatestItems();

        response.success[ItemsType.latest] = true;
        response.error[ItemsType.latest] = '';
        response.errorCode[ItemsType.latest] = "0";
        response.statusCode[ItemsType.latest] = 200;
        response.result[ItemsType.latest] = latestItems;
        emit(HomeFetchLatestSuccess(response));
      } catch (e) {
        response.success[ItemsType.latest] = false;
        response.error[ItemsType.latest] =
            'Error while loading list of latest items!';
        response.errorCode[ItemsType.latest] = "3";
        response.statusCode[ItemsType.latest] = 400;
        response.result[ItemsType.latest] = null;
        emit(HomeFetchLatestFailure(response));
      }
    });

    on<HomeFetchMostTagged>((event, emit) async {
      emit(HomeFetchMostTaggedLoading());
      var response = HomeBlocResponse({}, {}, {}, {}, {});

      try {
        var mostTaggedItems = await itemRepo.findItemsWithHighestTagCount();

        response.success[ItemsType.mostTagged] = true;
        response.error[ItemsType.mostTagged] = '';
        response.errorCode[ItemsType.mostTagged] = "0";
        response.statusCode[ItemsType.mostTagged] = 200;
        response.result[ItemsType.mostTagged] = mostTaggedItems;
        emit(HomeFetchMostTaggedSuccess(response));
      } catch (e) {
        response.success[ItemsType.mostTagged] = false;
        response.error[ItemsType.mostTagged] =
            'Error while loading list of most tagged items!';
        response.errorCode[ItemsType.mostTagged] = "5";
        response.statusCode[ItemsType.mostTagged] = 400;
        response.result[ItemsType.mostTagged] = null;
        emit(HomeFetchMostTaggedFailure(response));
      }
    });
  }
}
