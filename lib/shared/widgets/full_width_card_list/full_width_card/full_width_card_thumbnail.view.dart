import 'package:flutter/material.dart';

class FullWidthCardThumbnail extends StatelessWidget {
  final String imageSrc;

  const FullWidthCardThumbnail({
    Key? key,
    required this.imageSrc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(5.0),
        bottomLeft: Radius.circular(5.0),
      ),
      child: Image.network(
        imageSrc,
        fit: BoxFit.fill,
      ),
    );
  }
}
