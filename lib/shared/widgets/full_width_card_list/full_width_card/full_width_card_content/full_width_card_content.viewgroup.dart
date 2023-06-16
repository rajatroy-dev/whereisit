import 'package:flutter/material.dart';

import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/shared/widgets/full_width_card_list/full_width_card/full_width_card_content/full_width_card_location.view.dart';
import 'package:whereisit/shared/widgets/full_width_card_list/full_width_card/full_width_card_content/full_width_card_name.view.dart';
import 'package:whereisit/shared/widgets/full_width_card_list/full_width_card/full_width_card_content/full_width_card_quantity.view.dart';
import 'package:whereisit/shared/widgets/full_width_card_list/full_width_card/full_width_card_content/full_width_card_tags.viewgroup.dart';

class FullWidthCardContent extends StatelessWidget {
  final CardData data;

  const FullWidthCardContent({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FullWidthCardName(
          name: data.title,
          isFavorite: data.isFavorite ?? false,
        ),
        FullWidthCardLocation(location: data.location),
        FullWidthCardQuantity(qty: data.qty.toString()),
        FullWidthCardTags(tags: data.tags),
      ],
    );
  }
}
