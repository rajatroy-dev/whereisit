import 'package:flutter/material.dart';

class FullWidthCardThumbnail extends StatelessWidget {
  const FullWidthCardThumbnail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(5.0),
        bottomLeft: Radius.circular(5.0),
      ),
      child: Image.network(
        'https://picsum.photos/115',
        fit: BoxFit.fill,
      ),
    );
  }
}
