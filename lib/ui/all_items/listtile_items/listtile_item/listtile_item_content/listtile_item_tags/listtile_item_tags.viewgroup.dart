import 'package:flutter/material.dart';

import 'package:whereisit/ui/all_items/listtile_items/listtile_item/listtile_item_content/listtile_item_tags/listtile_item_tag.view.dart';

class ListItemItemTags extends StatelessWidget {
  final List<String> tags;

  const ListItemItemTags({
    Key? key,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Row(
        children: [
          ListTileItemTag(title: "# ${tags[0]}"),
          ListTileItemTag(title: "# ${tags[1]}"),
        ],
      ),
    );
  }
}
