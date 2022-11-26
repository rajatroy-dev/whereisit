import 'package:flutter/material.dart';

class ItemTag extends StatelessWidget {
  final String title;
  const ItemTag({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3.0),
      margin: const EdgeInsets.all(4.0),
      constraints: const BoxConstraints(
        maxWidth: 60,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(2.0),
        ),
        color: Colors.grey[300],
      ),
      child: Text(
        title,
        style: const TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
