import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:whereisit/screens/home/cubit/home_cubit.dart';
import 'package:whereisit/screens/home/items_list/items_list.viewgroup.dart';
import 'package:whereisit/screens/home/items_list/items_list_divider.view.dart';
import 'package:whereisit/screens/home/items_list/items_list_title.view.dart';
import 'package:whereisit/screens/home/tiles_container/tiles_container.viewgroup.dart';
import 'package:whereisit/shared/enums/items_type.enum.dart';
import 'package:whereisit/shared/enums/traits.enum.dart';
import 'package:whereisit/shared/widgets/list_error/list_error.viewgroup.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).fetchAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              if (state is FetchTilesListLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              if (state is FetchTilesListSuccess)
                TilesContainer(
                  list: state.response.result[ItemsType.tiles] != null
                      ? state.response.result[ItemsType.tiles]!
                      : [],
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ------------------- Favorite Items
                    const ItemsListDivider(),
                    const ItemsListTitle(listTitle: 'Favorite Items'),
                    if (state is FetchFavoritesListLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (state is FetchFavoritesListSuccess)
                      ItemsList(
                        list: state.response.result[ItemsType.favorite] != null
                            ? state.response.result[ItemsType.favorite]!
                            : [],
                        navigateTo: Traits.none,
                      ),
                    if (state is FetchFavoritesListFailure)
                      ListError(
                        errorMessage:
                            state.response.error[ItemsType.favorite] != null
                                ? state.response.error[ItemsType.favorite]!
                                : 'Something went wrong!',
                      ),
                    // ------------------- Favorite Items
                    // ------------------- Oldest Items
                    const ItemsListDivider(),
                    const ItemsListTitle(listTitle: 'Oldest Items'),
                    if (state is FetchOldestItemsLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (state is FetchOldestItemsSuccess)
                      ItemsList(
                        list: state.response.result[ItemsType.oldest] != null
                            ? state.response.result[ItemsType.oldest]!
                            : [],
                        navigateTo: Traits.none,
                      ),
                    if (state is FetchOldestItemsFailure)
                      ListError(
                        errorMessage:
                            state.response.error[ItemsType.oldest] != null
                                ? state.response.error[ItemsType.oldest]!
                                : 'Something went wrong!',
                      ),
                    // ------------------- Oldest Items
                    // ------------------- Latest Items
                    const ItemsListDivider(),
                    const ItemsListTitle(listTitle: 'Latest Items'),
                    if (state is FetchOldestItemsLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (state is FetchLatestItemsSuccess)
                      ItemsList(
                        list: state.response.result[ItemsType.latest] != null
                            ? state.response.result[ItemsType.latest]!
                            : [],
                        navigateTo: Traits.none,
                      ),
                    if (state is FetchLatestItemsFailure)
                      ListError(
                        errorMessage:
                            state.response.error[ItemsType.latest] != null
                                ? state.response.error[ItemsType.latest]!
                                : 'Something went wrong!',
                      ),
                    // ------------------- Latest Items
                    // ------------------- Most Tagged Items
                    const ItemsListDivider(),
                    const ItemsListTitle(listTitle: 'Latest Items'),
                    if (state is FetchMostTaggedItemsLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (state is FetchMostTaggedListSuccess)
                      ItemsList(
                        list:
                            state.response.result[ItemsType.mostTagged] != null
                                ? state.response.result[ItemsType.mostTagged]!
                                : [],
                        navigateTo: Traits.none,
                      ),
                    if (state is FetchMostTaggedListFailure)
                      ListError(
                        errorMessage:
                            state.response.error[ItemsType.mostTagged] != null
                                ? state.response.error[ItemsType.mostTagged]!
                                : 'Something went wrong!',
                      ),
                    // ------------------- Most Tagged Items
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
