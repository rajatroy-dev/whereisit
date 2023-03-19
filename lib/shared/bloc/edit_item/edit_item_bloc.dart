import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/models/list_item.model.dart';

part 'edit_item_event.dart';
part 'edit_item_state.dart';

class EditItemBloc extends Bloc<EditItemEvent, EditItemState> {
  var list = <CardData>[
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

  var newItem = CardData.empty();

  var tags = <ListItem>[
    ListItem(isSelected: false, isNew: false, item: 'Alaskan Malamute'),
    ListItem(isSelected: false, isNew: false, item: 'Bohemian Shepherd'),
    ListItem(isSelected: false, isNew: false, item: 'Cane Corso'),
    ListItem(isSelected: false, isNew: false, item: 'Dobermann'),
    ListItem(isSelected: false, isNew: false, item: 'English Mastiff'),
    ListItem(isSelected: false, isNew: false, item: 'Finnish Hound'),
    ListItem(isSelected: false, isNew: false, item: 'Great Dane'),
  ];

  EditItemBloc() : super(EditItemInitial()) {
    on<EditItemFavorite>((event, emit) {
      var item = event.itemData;

      for (var element in list) {
        if (element.id == item.id) {
          element.isFavorite = item.isFavorite;
        }
      }

      emit(EditItemFavoriteSuccess(item));
    });

    on<EditItemAll>((event, emit) {
      var item = list.firstWhere(
        (element) => element.id == event.id,
      );

      for (var element in list) {
        if (element.id == item.id) {
          element = CardData(
            id: item.id,
            title: item.title,
            imageSrc: item.imageSrc,
            location: item.location,
            qty: item.qty,
            tags: item.tags,
            createdAt: item.createdAt,
            isFavorite: item.isFavorite == null ? false : item.isFavorite!,
          );
        }
      }

      emit(EditItemFavoriteSuccess(item));
    });

    on<EditItemNew>((event, emit) {
      var item = CardData(
        id: event.itemData.id,
        title: event.itemData.title,
        imageSrc: event.itemData.imageSrc,
        location: event.itemData.location,
        qty: event.itemData.qty,
        tags: event.itemData.tags,
        createdAt: event.itemData.createdAt,
        isFavorite: false,
      );

      list.add(item);

      emit(EditItemNewSuccess(item));
    });

    on<EditItemTagsInitial>(
      (event, emit) => emit(EditItemToggleTagSuccess(tags)),
    );

    on<EditItemToggleTag>(
      (event, emit) {
        for (var element in tags) {
          if (element.item == event.tag.item) {
            element = ListItem(
              isNew: event.tag.isNew,
              item: event.tag.item,
              isSelected: event.tag.isSelected,
              value: event.tag.value,
            );
          }
        }

        emit(EditItemToggleTagSuccess(tags));
      },
    );
  }
}
