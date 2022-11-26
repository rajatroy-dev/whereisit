import 'package:flutter/material.dart';
import 'package:whereisit/ui/home/tiles/tile.view.dart';

class EachTilesRow extends StatelessWidget {
  final List<Tile> tiles;

  const EachTilesRow({
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
