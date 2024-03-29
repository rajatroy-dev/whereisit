import 'package:flutter/material.dart';

import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/shared/widgets/full_width_card_list/full_width_card_list.viewgroup.dart';
import 'package:whereisit/shared/widgets/sort_filter/sort_filter.viewgroup.dart';

class AllItemsScreen extends StatefulWidget {
  const AllItemsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AllItemsScreen> createState() => _AllItemsScreenState();
}

class _AllItemsScreenState extends State<AllItemsScreen> {
  final list = <CardData>[
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

  late bool isLoading;
  late List<CardData> filtered;
  _AllItemsScreenState() {
    filtered = list;
    isLoading = false;
  }

  handleChange(String data) {
    setState(() {
      isLoading = true;
    });
    if (data.isEmpty) {
      setState(() {
        filtered = [];
        isLoading = false;
      });
    } else {
      List<CardData> temp = [];
      setState(() {
        temp.addAll(list.where((element) => element.title.contains(data)));
        temp.addAll(list.where((element) => element.location.contains(data)));
        filtered = temp;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SortFilter(
          sortHandler: () {},
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 5.0,
          ),
          child: TextFormField(
            onChanged: handleChange,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Search . . .',
            ),
          ),
        ),
        Expanded(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : FullWidthCardList(list: filtered),
        ),
      ],
    );
  }
}
