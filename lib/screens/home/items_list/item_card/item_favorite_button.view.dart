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
    return Container(
      width: 24,
      height: 24,
      margin: const EdgeInsets.all(5.0),
      child: FittedBox(
        child: FloatingActionButton(
          heroTag: key,
          onPressed: () {},
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.favorite_rounded,
            size: 42,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
