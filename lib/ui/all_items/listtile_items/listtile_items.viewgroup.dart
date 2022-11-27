import 'package:flutter/material.dart';
import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/ui/all_items/listtile_items/listtile_item/listtile_item.viewgroup.dart';

class ListTileItems extends StatelessWidget {
  final List<CardData> list;
  const ListTileItems({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? const Center(
            child: Text("No data"),
          )
        : ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return ListTileItem(data: list[index]);
            },
          );
  }
}
