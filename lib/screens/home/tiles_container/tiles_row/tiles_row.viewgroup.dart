import 'package:flutter/material.dart';
import 'package:whereisit/screens/home/tiles_container/tiles_row/tile.view.dart';

class TilesRow extends StatelessWidget {
  final List<Tile> tiles;

  const TilesRow({
    Key? key,
    required this.tiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...tiles],
      ),
    );
  }
}
