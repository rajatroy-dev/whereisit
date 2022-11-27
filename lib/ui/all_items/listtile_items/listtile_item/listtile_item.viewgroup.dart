import 'package:flutter/material.dart';

import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/ui/all_items/listtile_items/listtile_item/listtile_item_content/listtile_item_content.viewgroup.dart';
import 'package:whereisit/ui/all_items/listtile_items/listtile_item/listtile_item_thumbnail.view.dart';

class ListTileItem extends StatelessWidget {
  final CardData data;

  const ListTileItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: SizedBox(
        height: 110,
        child: Row(
          children: [
            const ListTileItemThumbnail(),
            ListTileItemContent(data: data),
          ],
        ),
      ),
    );
  }
}
