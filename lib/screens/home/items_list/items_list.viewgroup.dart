import 'package:flutter/material.dart';

import 'package:whereisit/models/item_card_data.model.dart';
import 'package:whereisit/screens/home/items_list/item_card/item_card.viewgroup.dart';

class ItemsList extends StatelessWidget {
  final String listTitle;
  final List<ItemCardData> list;
  final String navigateTo;

  const ItemsList({
    Key? key,
    required this.listTitle,
    required this.list,
    required this.navigateTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 5),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.only(
              left: 5.0,
              bottom: 5.0,
            ),
            child: Text(
              listTitle,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return ItemCard(data: list[index]);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('View All'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
