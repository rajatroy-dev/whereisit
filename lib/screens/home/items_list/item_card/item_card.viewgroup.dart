import 'package:flutter/material.dart';

import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/screens/home/items_list/item_card/item_favorite_button.view.dart';
import 'package:whereisit/screens/home/items_list/item_card/item_location.view.dart';
import 'package:whereisit/screens/home/items_list/item_card/item_name.view.dart';
import 'package:whereisit/screens/home/items_list/item_card/item_quantity.view.dart';
import 'package:whereisit/screens/home/items_list/item_card/item_tags_list.viewgroup.dart';
import 'package:whereisit/screens/home/items_list/item_card/item_thumbnail.view.dart';
import 'package:whereisit/screens/view_item/view_item.screen.dart';
import 'package:whereisit/shared/intents/route_arguments.intent.dart';

class ItemCard extends StatelessWidget {
  final CardData data;

  const ItemCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        ViewItemScreen.routeName,
        arguments: RouteArguments(
          hasParams: true,
          params: {
            'id': data.id,
          },
        ),
      ),
      child: Card(
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
                    name: data.title,
                  ),
                  ItemLocation(
                    itemLocation: data.location,
                  ),
                  ItemQuantity(
                    itemQuantity: data.qty,
                  ),
                  ItemTagsList(
                    tags: data.tags,
                  )
                ],
              ),
            ),
            if (null != data.isFavorite && data.isFavorite!)
              ItemFavoriteButton(id: data.id),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
