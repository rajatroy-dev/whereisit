import 'package:flutter/material.dart';

class ItemThumbnail extends StatelessWidget {
  final String imgSrc;

  const ItemThumbnail({
    Key? key,
    required this.imgSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(5.0),
        topRight: Radius.circular(5.0),
      ),
      child: Image.network(
        'https://picsum.photos/200',
        fit: BoxFit.fill,
      ),
    );
  }
}
