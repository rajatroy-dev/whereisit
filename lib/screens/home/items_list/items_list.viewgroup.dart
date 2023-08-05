import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:whereisit/models/card_data.model.dart';
import 'package:whereisit/screens/filtered_items/bloc/filtered_items_bloc.dart';
import 'package:whereisit/screens/filtered_items/filtered_items.screen.dart';
import 'package:whereisit/screens/home/items_list/item_card/item_card.viewgroup.dart';
import 'package:whereisit/shared/enums/traits.enum.dart';

class ItemsList extends StatelessWidget {
  final List<CardData> list;
  final Traits navigateTo;

  const ItemsList({
    Key? key,
    required this.list,
    required this.navigateTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ItemCard(data: list[index]);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      FilteredItems.routeName,
                      arguments: navigateTo != Traits.none ? navigateTo : null,
                    ).then(
                      (_) => BlocProvider.of<FilteredItemsBloc>(context).add(
                        FilteredItemsClear(),
                      ),
                    ),
                    child: const Text('View All'),
                  ),
                ],
              ),
            ],
          )
        : const SizedBox(
            height: 150,
            width: double.infinity,
            child: Center(
              child: Text('No items to display!'),
            ),
          );
  }
}
