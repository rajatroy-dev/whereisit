import 'package:flutter/material.dart';

import 'package:whereisit/ui/home/items_list/item_card/item_tag.view.dart';

class ItemTagsList extends StatelessWidget {
  const ItemTagsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Wrap(
        clipBehavior: Clip.hardEdge,
        children: const [
          ItemTag(title: '#abcdef'),
          ItemTag(title: '#ghijkl'),
        ],
      ),
    );
  }
}
