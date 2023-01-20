import 'package:flutter/material.dart';

import 'package:whereisit/models/item_card_data.model.dart';
import 'package:whereisit/screens/home/items_list/item_card/item_card.viewgroup.dart';

class ItemsList extends StatelessWidget {
  final List<ItemCardData> list;

  const ItemsList({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ItemCard(data: list[index]);
        },
      ),
    );
  }
}
