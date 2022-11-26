import 'package:flutter/material.dart';

class ItemQuantity extends StatelessWidget {
  const ItemQuantity({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(
        5.0,
      ),
      child: Text("Qty: 5"),
    );
  }
}
