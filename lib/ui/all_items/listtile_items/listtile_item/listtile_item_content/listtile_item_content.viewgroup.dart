import 'package:flutter/material.dart';

import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/ui/all_items/listtile_items/listtile_item/listtile_item_content/listtile_item_location.view.dart';
import 'package:whereisit/ui/all_items/listtile_items/listtile_item/listtile_item_content/listtile_item_name.view.dart';
import 'package:whereisit/ui/all_items/listtile_items/listtile_item/listtile_item_content/listtile_item_quantity.view.dart';
import 'package:whereisit/ui/all_items/listtile_items/listtile_item/listtile_item_content/listtile_item_tags/listtile_item_tags.viewgroup.dart';

class ListTileItemContent extends StatelessWidget {
  final CardData data;

  const ListTileItemContent({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTileItemName(name: data.title),
        ListTileItemLocation(location: data.location),
        ListTileItemQuantity(qty: data.qty.toString()),
        ListItemItemTags(tags: data.tags),
      ],
    );
  }
}
