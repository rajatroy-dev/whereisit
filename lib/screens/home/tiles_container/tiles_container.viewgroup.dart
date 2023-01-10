import 'package:flutter/material.dart';
import 'package:whereisit/screens/home/tiles_container/tiles_row/tiles_row.viewgroup.dart';
import 'package:whereisit/screens/home/tiles_container/tiles_row/tile.view.dart';

class TilesContainer extends StatelessWidget {
  const TilesContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TilesRow(
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
        TilesRow(
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
