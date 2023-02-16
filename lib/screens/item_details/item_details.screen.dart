import 'package:flutter/material.dart';
import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/screens/home/items_list/item_card/item_location.view.dart';
import 'package:whereisit/screens/home/items_list/item_card/item_quantity.view.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
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
      action: AppBarAction.edit,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    intent.data.imageSrc.replaceAll('115', '300'),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                intent.data.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ItemLocation(itemLocation: intent.data.location),
            ItemQuantity(itemQuantity: intent.data.qty),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5.0),
                    child: Icon(Icons.today_rounded, size: 16.0),
                  ),
                  Text(intent.data.createdAt),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
