import 'package:flutter/material.dart';

class FullWidthCardQuantity extends StatelessWidget {
  final String qty;

  const FullWidthCardQuantity({
    Key? key,
    required this.qty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Text("Qty: $qty"),
    );
  }
}
