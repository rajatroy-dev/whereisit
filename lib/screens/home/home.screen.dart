import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/home/bloc/home_bloc.dart';
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
    BlocProvider.of<HomeBloc>(context).add(HomeFetchTiles());
    BlocProvider.of<HomeBloc>(context).add(HomeFetchOldest());
    BlocProvider.of<HomeBloc>(context).add(HomeFetchLatest());
    BlocProvider.of<HomeBloc>(context).add(HomeFetchFavorites());
    BlocProvider.of<HomeBloc>(context).add(HomeFetchMostTagged());
    super.initState();
  }

  _whenToBuild(ItemsType type, HomeState current) {
    var result = false;

    switch (type) {
      case ItemsType.favorite:
        result = current is HomeFetchFavoritesLoading ||
            current is HomeFetchFavoritesSuccess ||
            current is HomeFetchFavoritesFailure;
        break;
      case ItemsType.oldest:
        result = current is HomeFetchOldestLoading ||
            current is HomeFetchOldestSuccess ||
            current is HomeFetchOldestFailure;
        break;
      case ItemsType.latest:
        result = current is HomeFetchLatestLoading ||
            current is HomeFetchLatestSuccess ||
            current is HomeFetchLatestFailure;
        break;
      case ItemsType.mostTagged:
        result = current is HomeFetchMostTaggedLoading ||
            current is HomeFetchMostTaggedSuccess ||
            current is HomeFetchMostTaggedFailure;
        break;
      default:
        break;
    }

    return result;
  }

  _buildProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) =>
                current is HomeFetchTilesLoading ||
                current is HomeFetchTilesSuccess,
            builder: (context, state) {
              if (state is HomeFetchTilesLoading) {
                _buildProgressIndicator();
              }
              if (state is HomeFetchTilesSuccess) {
                return TilesContainer(
                  list: state.response.result[ItemsType.tiles] != null
                      ? state.response.result[ItemsType.tiles]!
                      : [],
                );
              }
              if (state is HomeFetchTilesFailure) {
                return ListError(
                  errorMessage: state.response.error[ItemsType.favorite] != null
                      ? state.response.error[ItemsType.favorite]!
                      : 'Something went wrong!',
                );
              }
              return const SizedBox();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ------------------- Favorite Items
                const ItemsListDivider(),
                const ItemsListTitle(listTitle: 'Favorite Items'),
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      _whenToBuild(ItemsType.favorite, current),
                  builder: (context, state) {
                    if (state is HomeFetchFavoritesLoading) {
                      _buildProgressIndicator();
                    }
                    if (state is HomeFetchFavoritesSuccess) {
                      return ItemsList(
                        list: state.response.result[ItemsType.favorite] != null
                            ? state.response.result[ItemsType.favorite]!
                            : [],
                        navigateTo: Traits.none,
                      );
                    }
                    if (state is HomeFetchFavoritesFailure) {
                      return ListError(
                        errorMessage:
                            state.response.error[ItemsType.favorite] != null
                                ? state.response.error[ItemsType.favorite]!
                                : 'Something went wrong!',
                      );
                    }
                    return const SizedBox();
                  },
                ),
                // ------------------- Favorite Items
                // ------------------- Oldest Items
                const ItemsListDivider(),
                const ItemsListTitle(listTitle: 'Oldest Items'),
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      _whenToBuild(ItemsType.oldest, current),
                  builder: (context, state) {
                    if (state is HomeFetchOldestLoading) {
                      _buildProgressIndicator();
                    }
                    if (state is HomeFetchOldestSuccess) {
                      return ItemsList(
                        list: state.response.result[ItemsType.oldest] != null
                            ? state.response.result[ItemsType.oldest]!
                            : [],
                        navigateTo: Traits.none,
                      );
                    }
                    if (state is HomeFetchOldestFailure) {
                      return ListError(
                        errorMessage:
                            state.response.error[ItemsType.oldest] != null
                                ? state.response.error[ItemsType.oldest]!
                                : 'Something went wrong!',
                      );
                    }
                    return const SizedBox();
                  },
                ),
                // ------------------- Oldest Items
                // ------------------- Latest Items
                const ItemsListDivider(),
                const ItemsListTitle(listTitle: 'Latest Items'),
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      _whenToBuild(ItemsType.latest, current),
                  builder: (context, state) {
                    if (state is HomeFetchLatestLoading) {
                      _buildProgressIndicator();
                    }
                    if (state is HomeFetchLatestSuccess) {
                      return ItemsList(
                        list: state.response.result[ItemsType.latest] != null
                            ? state.response.result[ItemsType.latest]!
                            : [],
                        navigateTo: Traits.none,
                      );
                    }
                    if (state is HomeFetchLatestFailure) {
                      return ListError(
                        errorMessage:
                            state.response.error[ItemsType.latest] != null
                                ? state.response.error[ItemsType.latest]!
                                : 'Something went wrong!',
                      );
                    }
                    return const SizedBox();
                  },
                ),
                // ------------------- Latest Items
                // ------------------- Most Tagged Items
                const ItemsListDivider(),
                const ItemsListTitle(listTitle: 'Most Tagged Items'),
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      _whenToBuild(ItemsType.mostTagged, current),
                  builder: (context, state) {
                    if (state is HomeFetchMostTaggedLoading) {
                      _buildProgressIndicator();
                    }
                    if (state is HomeFetchMostTaggedSuccess) {
                      return ItemsList(
                        list:
                            state.response.result[ItemsType.mostTagged] != null
                                ? state.response.result[ItemsType.mostTagged]!
                                : [],
                        navigateTo: Traits.none,
                      );
                    }
                    if (state is HomeFetchMostTaggedFailure) {
                      return ListError(
                        errorMessage:
                            state.response.error[ItemsType.mostTagged] != null
                                ? state.response.error[ItemsType.mostTagged]!
                                : 'Something went wrong!',
                      );
                    }
                    return const SizedBox();
                  },
                ),
                // ------------------- Most Tagged Items
              ],
            ),
          ),
        ],
      ),
    );
  }
}
