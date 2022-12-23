import 'package:flutter/material.dart';

import 'package:whereisit/shared/ui/full_width_card_list/full_width_card/full_width_card_content/full_width_card_tags/full_width_card_tag.view.dart';

class FullWidthCardTags extends StatelessWidget {
  final List<String> tags;

  const FullWidthCardTags({
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
          FullWidthCardTag(title: "# ${tags[0]}"),
          FullWidthCardTag(title: "# ${tags[1]}"),
        ],
      ),
    );
  }
}
