import 'package:flutter/material.dart';

class FullWidthCardName extends StatelessWidget {
  final String name;
  final bool isFavorite;

  const FullWidthCardName({
    Key? key,
    required this.name,
    required this.isFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isFavorite)
            GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.favorite_rounded,
                size: 18,
              ),
            ),
        ],
      ),
    );
  }
}
