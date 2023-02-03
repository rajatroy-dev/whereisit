import 'dart:math';

import 'package:flutter/material.dart';

class ItemFavoriteButton extends StatelessWidget {
  final String id;

  const ItemFavoriteButton({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(5.0),
      child: CircleAvatar(
        radius: 14,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.favorite_rounded,
          size: 20,
          color: Colors.green,
        ),
      ),
    );
  }
}
