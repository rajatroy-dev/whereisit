import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whereisit/data/repository/category_repository.dart';
import 'package:whereisit/data/repository/item_repository.dart';
import 'package:whereisit/data/repository/location_repository.dart';
import 'package:whereisit/data/repository/property_repository.dart';
import 'package:whereisit/data/repository/room_repository.dart';
import 'package:whereisit/data/repository/tag_repository.dart';

part 'filter_options_event.dart';
part 'filter_options_state.dart';

class FilterOptionsBloc extends Bloc<FilterOptionsEvent, FilterOptionsState> {
  final itemRepo = ItemRepository();
  final categoryRepo = CategoryRepository();
  final locationRepo = LocationRepository();
  final propertyRepo = PropertyRepository();
  final roomRepo = RoomRepository();
  final tagRepo = TagRepository();

  FilterOptionsBloc() : super(FilterOptionsInitial()) {
    on<FilterOptionsLoad>((event, emit) async {
      var items = await itemRepo.findFavoriteItems();
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
    });
  }
}
