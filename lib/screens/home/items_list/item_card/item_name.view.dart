import 'package:flutter/material.dart';

class ItemName extends StatelessWidget {
  const ItemName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(5.0),
      child: Text(
        'A random picture',
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
