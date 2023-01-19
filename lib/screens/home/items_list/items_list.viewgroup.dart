import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/home/cubit/home_cubit.dart';

import 'package:whereisit/screens/home/items_list/item_card/item_card.viewgroup.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is FetchAllLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is FetchAllComplete) {
            if (state.response.success['item_card']!) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.response.result['item_card'].length,
                itemBuilder: (context, index) {
                  return ItemCard(
                      data: state.response.result['item_card'][index]);
                },
              );
            }
            return Center(
              child: Text(state.response.error['item_card']!),
            );
          }

          if (state is FetchOldestItemsSuccess) {}

          return const SizedBox();
        },
      ),
    );
  }
}
