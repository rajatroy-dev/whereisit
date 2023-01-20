import 'package:flutter/material.dart';

import 'package:whereisit/models/tiles_details_data.model.dart';
import 'package:whereisit/screens/home/tiles_container/tiles_row/tiles_row.viewgroup.dart';
import 'package:whereisit/screens/home/tiles_container/tiles_row/tile.view.dart';

class TilesContainer extends StatelessWidget {
  final List<TilesDetailsData> list;

  const TilesContainer({
    Key? key,
    required this.list,
  }) : super(key: key);

  final Map<String, IconData> iconMap = const {
    'Property': Icons.apartment_rounded,
    'Room': Icons.space_dashboard_outlined,
    'Area': Icons.all_inbox_rounded,
    'Item': Icons.move_to_inbox_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildTilesContainer(),
    );
  }

  List<Widget> _buildTilesContainer() {
    List<Tile> firstRow = [];
    List<Tile> secondRow = [];

    for (var i = 0; i < list.length; i++) {
      if (i % 2 == 0) {
        firstRow.add(Tile(
          tileIcon: iconMap[list[i].type]!,
          tileName: list[i].type,
        ));
      } else {
        secondRow.add(Tile(
          tileIcon: iconMap[list[i].type]!,
          tileName: list[i].type,
        ));
      }
    }

    return [
      TilesRow(
        tiles: firstRow,
      ),
      TilesRow(
        tiles: secondRow,
      )
    ];
  }
}
