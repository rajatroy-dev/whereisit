import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/shared/enums/traits.enum.dart';

part 'filtered_items_event.dart';
part 'filtered_items_state.dart';

class FilteredItemsBloc extends Bloc<FilteredItemsEvent, FilteredItemsState> {
  final _list = <CardData>[
    CardData(
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 1",
      location: "A random location 1",
      qty: 5,
      tags: ["tag1", "tag2"],
      isFavorite: true,
    ),
    CardData(
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 2",
      location: "A random location 2",
      qty: 6,
      tags: ["tag3", "tag4"],
    ),
    CardData(
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 3",
      location: "A random location 3",
      qty: 7,
      tags: ["tag5", "tag6"],
      isFavorite: true,
    ),
    CardData(
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 4",
      location: "A random location 4",
      qty: 8,
      tags: ["tag1", "tag6"],
    ),
    CardData(
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 5",
      location: "A random location 5",
      qty: 9,
      tags: ["tag2", "tag5"],
      isFavorite: false,
    ),
    CardData(
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 6",
      location: "A random location 6",
      qty: 1,
      tags: ["tag3", "tag4"],
    ),
    CardData(
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 7",
      location: "A random location 7",
      qty: 2,
      tags: ["tag7", "tag8"],
    ),
    CardData(
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 8",
      location: "A random location 8",
      qty: 3,
      tags: ["tag9", "tag10"],
    ),
    CardData(
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 9",
      location: "A random location 9",
      qty: 4,
      tags: ["tag7", "tag10"],
    ),
    CardData(
      imageSrc: 'https://picsum.photos/115',
      title: "A random picture 10",
      location: "A random location 10",
      qty: 10,
      tags: ["tag8", "tag9"],
    ),
  ];

  FilteredItemsBloc() : super(FilteredItemsInitial()) {
    on<FilteredItemsBy>((event, emit) {
      emit(FilteredItemsLoading());

      var filtered = <CardData>[];

      if (event.filterBy == Traits.favorites) {
        for (var element in _list) {
          if (null != element.isFavorite && element.isFavorite!) {
            filtered.add(
              CardData(
                imageSrc: element.imageSrc,
                title: element.imageSrc,
                location: element.imageSrc,
                qty: element.qty,
                tags: element.tags,
              ),
            );
          }
        }
      }

      emit(FilteredItemsSuccess(filtered));
    });
  }
}
