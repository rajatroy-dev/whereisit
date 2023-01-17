import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/models/tiles_details.model.dart';

import 'package:whereisit/screens/home/cubit/home_cubit.dart';
import 'package:whereisit/screens/home/tiles_container/tiles_row/tiles_row.viewgroup.dart';
import 'package:whereisit/screens/home/tiles_container/tiles_row/tile.view.dart';

class TilesContainer extends StatelessWidget {
  const TilesContainer({
    Key? key,
  }) : super(key: key);

  final Map<String, IconData> iconMap = const {
    'Property': Icons.apartment_rounded,
    'Room': Icons.space_dashboard_outlined,
    'Area': Icons.all_inbox_rounded,
    'Item': Icons.move_to_inbox_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is FetchTilesDetailsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is FetchTilesDetailsFailure) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is FetchTilesDetailsSuccess) {
          return Column(
            children: _buildTilesContainer(state.tilesDetails),
          );
        }

        return const SizedBox();
      },
    );
  }

  List<Widget> _buildTilesContainer(List<TilesDetails> list) {
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
