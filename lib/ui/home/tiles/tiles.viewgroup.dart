import 'package:flutter/material.dart';
import 'package:whereisit/ui/home/tiles/each_tiles_row.viewgroup.dart';
import 'package:whereisit/ui/home/tiles/tile.view.dart';

class Tiles extends StatelessWidget {
  const Tiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        EachTilesRow(
          tiles: [
            Tile(
              tileIcon: Icons.apartment_rounded,
              tileName: 'Property',
            ),
            Tile(
              tileIcon: Icons.space_dashboard_outlined,
              tileName: 'Room',
            ),
          ],
        ),
        EachTilesRow(
          tiles: [
            Tile(
              tileIcon: Icons.all_inbox_rounded,
              tileName: 'Area',
            ),
            Tile(
              tileIcon: Icons.move_to_inbox_rounded,
              tileName: 'Item',
            ),
          ],
        )
      ],
    );
  }
}
