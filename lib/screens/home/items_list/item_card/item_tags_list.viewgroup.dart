import 'package:flutter/material.dart';

import 'package:whereisit/screens/home/items_list/item_card/item_tag.view.dart';

class ItemTagsList extends StatelessWidget {
  final List<String> tags;

  const ItemTagsList({
    Key? key,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Wrap(
        clipBehavior: Clip.hardEdge,
        children: _buildTagsList(),
      ),
    );
  }

  List<Widget> _buildTagsList() {
    var list = <ItemTag>[];
    for (var i = 0; i < tags.length; i++) {
      list.add(ItemTag(title: '#${tags[i]}'));
    }
    return list;
  }
}
