import 'package:flutter/material.dart';
import 'package:whereisit/models/item_card_data.model.dart';

import 'package:whereisit/screens/home/items_list/item_card/item_favorite_button.view.dart';
import 'package:whereisit/screens/home/items_list/item_card/item_location.view.dart';
import 'package:whereisit/screens/home/items_list/item_card/item_name.view.dart';
import 'package:whereisit/screens/home/items_list/item_card/item_quantity.view.dart';
import 'package:whereisit/screens/home/items_list/item_card/item_tags_list.viewgroup.dart';
import 'package:whereisit/screens/home/items_list/item_card/item_thumbnail.view.dart';

class ItemCard extends StatelessWidget {
  final ItemCardData data;

  const ItemCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          SizedBox(
            width: 149,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemThumbnail(
                  imgSrc: data.imageSrc,
                ),
                ItemName(
                  name: data.name,
                ),
                ItemLocation(
                  itemLocation: data.locationName,
                ),
                ItemQuantity(
                  itemQuantity: data.quantity,
                ),
                ItemTagsList(
                  tags: data.tags,
                )
              ],
            ),
          ),
          const ItemFavoriteButton(),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
