import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whereisit/data/repository/category_repository.dart';
import 'package:whereisit/data/repository/item_repository.dart';
import 'package:whereisit/data/repository/location_repository.dart';
import 'package:whereisit/data/repository/property_repository.dart';
import 'package:whereisit/data/repository/room_repository.dart';
import 'package:whereisit/data/repository/tag_repository.dart';
import 'package:whereisit/shared/enums/available_filters.enum.dart';

part 'filter_options_event.dart';
part 'filter_options_state.dart';

class FilterOptionsBloc extends Bloc<FilterOptionsEvent, FilterOptionsState> {
  final itemRepo = ItemRepository();
  final categoryRepo = CategoryRepository();
  final locationRepo = LocationRepository();
  final propertyRepo = PropertyRepository();
  final roomRepo = RoomRepository();
  final tagRepo = TagRepository();

  var appliedFiltersRecord = <Map<String, List<int>>>{};

  FilterOptionsBloc() : super(FilterOptionsInitial()) {
    on<FilterOptionsLoad>((event, emit) async {
      var categories = await itemRepo.findItemsWithCategories();
      var locations = await itemRepo.findItemsWithLocations();
      var properties = await itemRepo.findItemsWithProperties();
    });

    on<FilterOptionsLoadForFavorites>((event, emit) async {
      try {
        // TODO: Change from favorite to generic
        var items = await itemRepo.findFavoriteItems();

        if (items.isEmpty) {
          emit(FilterOptionsLoadFailure());
          return;
        }

        var categories = <int>[];
        var locations = <int>[];
        var properties = <int>[];
        var rooms = <int>[];
        var tags = <int>[];

        for (var item in items) {
          if (item.categoryId != null) {
            categories.add(item.categoryId!);
          }
          if (item.locationId != null) {
            locations.add(item.locationId!);
          }
          if (item.propertyId != null) {
            properties.add(item.propertyId!);
          }
          if (item.roomId != null) {
            rooms.add(item.roomId!);
          }
          var taggedItems = await tagRepo.findTagsByItem(item.id!);
          for (var tag in taggedItems) {
            tags.add(tag.id);
          }
        }

        var result = {
          "categories": categories,
          "locations": locations,
          "properties": properties,
          "rooms": rooms,
          "tags": tags,
        };

        emit(FilterOptionsLoadForFavoritesSuccess(result));
      } catch (e) {
        emit(FilterOptionsLoadFailure());
      }
    });

    on<FilterOptionsLoadType>((event, emit) async {
      try {
        switch (event.filterType) {
          case AvailableFilters.property:
            var properties = await propertyRepo.findByIds(event.ids);
            emit(FilterOptionsLoadTypeSuccess(properties));
            break;
          case AvailableFilters.location:
            var locations = await locationRepo.findByIds(event.ids);
            emit(FilterOptionsLoadTypeSuccess(locations));
            break;
          case AvailableFilters.room:
            var rooms = await roomRepo.findByIds(event.ids);
            emit(FilterOptionsLoadTypeSuccess(rooms));
            break;
          default:
            break;
        }
      } catch (e) {
        emit(FilterOptionsLoadTypeFailure());
      }
    });
  }
}
