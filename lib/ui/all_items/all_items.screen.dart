import 'package:flutter/material.dart';

import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/ui/all_items/listtile_items/listtile_items.viewgroup.dart';

class AllItems extends StatefulWidget {
  const AllItems({
    Key? key,
  }) : super(key: key);

  @override
  State<AllItems> createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  final list = <CardData>[
    CardData(
      title: "A random picture 1",
      location: "A random location 1",
      qty: 5,
      tags: ["tag1", "tag2"],
    ),
    CardData(
      title: "A random picture 2",
      location: "A random location 2",
      qty: 6,
      tags: ["tag3", "tag4"],
    ),
    CardData(
      title: "A random picture 3",
      location: "A random location 3",
      qty: 7,
      tags: ["tag5", "tag6"],
    ),
    CardData(
      title: "A random picture 4",
      location: "A random location 4",
      qty: 8,
      tags: ["tag1", "tag6"],
    ),
    CardData(
      title: "A random picture 5",
      location: "A random location 5",
      qty: 9,
      tags: ["tag2", "tag5"],
    ),
    CardData(
      title: "A random picture 6",
      location: "A random location 6",
      qty: 1,
      tags: ["tag3", "tag4"],
    ),
    CardData(
      title: "A random picture 7",
      location: "A random location 7",
      qty: 2,
      tags: ["tag7", "tag8"],
    ),
    CardData(
      title: "A random picture 8",
      location: "A random location 8",
      qty: 3,
      tags: ["tag9", "tag10"],
    ),
    CardData(
      title: "A random picture 9",
      location: "A random location 9",
      qty: 4,
      tags: ["tag7", "tag10"],
    ),
    CardData(
      title: "A random picture 10",
      location: "A random location 10",
      qty: 10,
      tags: ["tag8", "tag9"],
    ),
  ];

  late bool isLoading;
  late List<CardData> filtered;
  _AllItemsState() {
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
      children: [
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
              : ListTileItems(list: filtered),
        ),
      ],
    );
  }
}
