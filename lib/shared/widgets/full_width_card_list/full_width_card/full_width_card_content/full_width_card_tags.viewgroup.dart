import 'package:flutter/material.dart';

import 'package:whereisit/shared/widgets/pill_tag.view.dart';

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
          PillTag(title: "# ${tags[0]}"),
          PillTag(title: "# ${tags[1]}"),
        ],
      ),
    );
  }
}
