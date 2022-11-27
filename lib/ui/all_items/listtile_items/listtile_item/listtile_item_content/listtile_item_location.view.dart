import 'package:flutter/material.dart';

class ListTileItemLocation extends StatelessWidget {
  final String location;

  const ListTileItemLocation({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 4,
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: Icon(Icons.location_on_rounded, size: 16.0),
          ),
          Text(location),
        ],
      ),
    );
  }
}
