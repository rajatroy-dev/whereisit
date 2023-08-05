import 'package:flutter/material.dart';

class ItemsListDivider extends StatelessWidget {
  const ItemsListDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Divider(height: 5),
        SizedBox(height: 14),
      ],
    );
  }
}
