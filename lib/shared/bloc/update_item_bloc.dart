import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whereisit/models/card_data.model.dart';

part 'update_item_event.dart';
part 'update_item_state.dart';

class UpdateItemBloc extends Bloc<UpdateItemEvent, UpdateItemState> {
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

  UpdateItemBloc() : super(UpdateItemInitial()) {
    on<UpdateItemFavorite>((event, emit) {
      var item = event.itemData;

      for (var element in list) {
        if (element.id == item.id) {
          element.isFavorite = item.isFavorite;
        }
      }

      emit(UpdateItemFavoriteSuccess(item));
    });

    on<UpdateItemAll>((event, emit) {
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

      emit(UpdateItemFavoriteSuccess(item));
    });

    on<UpdateItemNew>((event, emit) {
      var item = CardData(
        id: '',
        title: '',
        imageSrc: event.image,
        location: '',
        qty: 0,
        tags: [],
        createdAt: '',
        isFavorite: false,
      );

      emit(UpdateItemFavoriteSuccess(item));
    });
  }
}
