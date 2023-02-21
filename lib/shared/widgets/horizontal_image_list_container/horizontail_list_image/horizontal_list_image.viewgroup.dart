import 'package:flutter/material.dart';

class HorizontalListImage extends StatelessWidget {
  const HorizontalListImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        'https://picsum.photos/115',
        height: 115.0,
        width: 115.0,
      ),
    );
  }
}
