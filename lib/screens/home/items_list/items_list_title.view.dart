import 'package:flutter/material.dart';

class ItemsListTitle extends StatelessWidget {
  final String listTitle;

  const ItemsListTitle({
    Key? key,
    required this.listTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5.0,
        bottom: 5.0,
      ),
      child: Text(
        listTitle,
        style: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
