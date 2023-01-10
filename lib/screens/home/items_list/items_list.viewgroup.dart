import 'package:flutter/material.dart';

import 'package:whereisit/screens/home/items_list/item_card/item_card.viewgroup.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          ItemCard(),
          ItemCard(),
          ItemCard(),
          ItemCard(),
        ],
      ),
    );
  }
}
