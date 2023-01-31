import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/shared/enums/chronology.enum.dart';
import 'package:whereisit/shared/enums/traits.enum.dart';

part 'filtered_items_event.dart';
part 'filtered_items_state.dart';

class FilteredItemsBloc extends Bloc<FilteredItemsEvent, FilteredItemsState> {
  final _list = <CardData>[
    CardData(
      id: "1",
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 1",
      location: "A random location 1",
      qty: 5,
      tags: ["tag1", "tag2"],
      createdAt: "2022-12-03",
      isFavorite: true,
    ),
    CardData(
      id: "2",
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 2",
      location: "A random location 2",
      qty: 6,
      tags: ["tag3", "tag4"],
      createdAt: "2022-11-13",
    ),
    CardData(
      id: "3",
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 3",
      location: "A random location 3",
      qty: 7,
      tags: ["tag5", "tag6"],
      createdAt: "2022-10-11",
      isFavorite: true,
    ),
    CardData(
      id: "4",
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 4",
      location: "A random location 4",
      qty: 8,
      tags: ["tag1", "tag6"],
      createdAt: "2022-09-05",
    ),
    CardData(
      id: "5",
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 5",
      location: "A random location 5",
      qty: 9,
      tags: ["tag2", "tag5"],
      createdAt: "2022-08-15",
      isFavorite: false,
    ),
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

  var filtered = <CardData>[];

  FilteredItemsBloc() : super(FilteredItemsInitial()) {
    on<FilteredItemsClear>((event, emit) => filtered.clear());

    on<FilteredItemsBy>((event, emit) {
      emit(FilteredItemsLoading());

      if (event.filterBy == Traits.favorites && filtered.isEmpty) {
        for (var element in _list) {
          if (null != element.isFavorite && element.isFavorite!) {
            filtered.add(
              CardData(
                  id: element.id,
                  imageSrc: element.imageSrc,
                  title: element.title,
                  location: element.location,
                  qty: element.qty,
                  tags: element.tags,
                  createdAt: element.createdAt,
                  isFavorite: element.isFavorite ?? false),
            );
          }
        }

        emit(FilteredItemsSuccess(filtered));
      } else {
        emit(FilteredItemsSuccess(filtered));
        // emit(FilteredItemsFailure('Failed to load items'));
      }
    });

    on<FilteredItemsSearch>((event, emit) {
      emit(FilteredItemsLoading());

      filtered.addAll(
        _list.where((element) => element.title.contains(event.searchTerm)),
      );
      filtered.addAll(
        _list.where((element) => element.location.contains(event.searchTerm)),
      );

      emit(FilteredItemsSuccess(filtered));
    });

    on<FilteredItemsSort>((event, emit) {
      emit(FilteredItemsLoading());

      if (event.sortBy == Chronology.newestFirst) {
        filtered.sort((a, b) {
          var aDate = DateTime.tryParse(a.createdAt);
          var bDate = DateTime.tryParse(b.createdAt);

          if (aDate == null && bDate != null) {
            return -1;
          } else if (aDate != null && bDate == null) {
            return 1;
          } else if (aDate == null && bDate == null) {
            return 0;
          } else {
            return bDate!.compareTo(aDate!);
          }
        });
      } else if (event.sortBy == Chronology.oldestFirst) {
        filtered.sort((a, b) {
          var aDate = DateTime.tryParse(a.createdAt);
          var bDate = DateTime.tryParse(b.createdAt);

          if (aDate == null && bDate != null) {
            return 1;
          } else if (aDate != null && bDate == null) {
            return -1;
          } else if (aDate == null && bDate == null) {
            return 0;
          } else {
            return aDate!.compareTo(bDate!);
          }
        });
      }

      emit(FilteredItemsSuccess(filtered));
    });
  }
}
