import 'package:flutter/material.dart';

import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/shared/ui/full_width_card_list/full_width_card/full_width_card_content/full_width_card_content.viewgroup.dart';
import 'package:whereisit/shared/ui/full_width_card_list/full_width_card/full_width_card_thumbnail.view.dart';

class FullWidthCard extends StatelessWidget {
  final CardData data;

  const FullWidthCard({
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
            const FullWidthCardThumbnail(),
            Expanded(
              child: FullWidthCardContent(data: data),
            ),
          ],
        ),
      ),
    );
  }
}
