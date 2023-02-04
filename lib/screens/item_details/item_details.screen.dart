import 'package:flutter/material.dart';
import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/shared/intents/Item_details.intent.dart';
import 'package:whereisit/shared/widgets/app_scaffold.viewgroup.dart';

class ItemDetails extends StatefulWidget {
  static const routeName = '/item-details';

  const ItemDetails({Key? key}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    var intent = ItemDetailsIntent(
      isSuccess: false,
      data: CardData.empty(),
    );

    if (null != args && args is CardData) {
      intent = ItemDetailsIntent(
        isSuccess: true,
        data: args,
      );
    }

    return AppScaffold(
      body: Column(
        children: [
          Text(intent.data.id),
          Text(intent.data.imageSrc),
          Text(intent.data.title),
          Text(intent.data.location),
          Text(intent.data.qty.toString()),
          Text(intent.data.createdAt),
        ],
      ),
    );
  }
}
