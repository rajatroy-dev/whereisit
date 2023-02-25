import 'dart:io';

import 'package:flutter/material.dart';

class HorizontalListImage extends StatelessWidget {
  final String image;

  const HorizontalListImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.file(
        File(image),
        height: 115.0,
        width: 115.0,
      ),
    );
  }
}
