import 'package:flutter/material.dart';

class ItemQuantity extends StatelessWidget {
  final int itemQuantity;

  const ItemQuantity({
    Key? key,
    required this.itemQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        5.0,
      ),
      child: Text('Qty: $itemQuantity'),
    );
  }
}
