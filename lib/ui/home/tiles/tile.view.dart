import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final IconData tileIcon;
  final String tileName;

  const Tile({
    Key? key,
    required this.tileIcon,
    required this.tileName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        height: 100,
        width: 150,
        child: Card(
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                tileIcon,
                size: 40,
              ),
              Text(tileName),
            ],
          ),
        ),
      ),
    );
  }
}
