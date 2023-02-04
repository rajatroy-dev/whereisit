import 'package:whereisit/models/card_data.model.dart';

class ItemDetailsIntent {
  bool? isSuccess;
  final CardData data;

  ItemDetailsIntent({
    this.isSuccess,
    required this.data,
  });
}
