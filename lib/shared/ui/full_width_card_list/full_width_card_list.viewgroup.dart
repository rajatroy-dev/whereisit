import 'package:flutter/material.dart';
import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/shared/ui/full_width_card_list/full_width_card/full_width_card.viewgroup.dart';

class FullWidthCardList extends StatelessWidget {
  final List<CardData> list;
  const FullWidthCardList({
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
              return FullWidthCard(data: list[index]);
            },
          );
  }
}
