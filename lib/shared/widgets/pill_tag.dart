import 'package:flutter/material.dart';

class PillTag extends StatelessWidget {
  final String title;
  final bool isShort;

  const PillTag({
    Key? key,
    required this.title,
    this.isShort = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 8.0,
      ),
      margin: const EdgeInsets.all(4.0),
      constraints: isShort
          ? const BoxConstraints(
              maxWidth: 60,
            )
          : null,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
        color: Colors.grey[300],
      ),
      child: Text(
        title,
        style: isShort
            ? const TextStyle(
                overflow: TextOverflow.ellipsis,
              )
            : null,
      ),
    );
  }
}
