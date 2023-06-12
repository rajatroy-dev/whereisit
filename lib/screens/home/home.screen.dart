import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:whereisit/screens/home/cubit/home_cubit.dart';
import 'package:whereisit/screens/home/items_list/items_list.viewgroup.dart';
import 'package:whereisit/screens/home/tiles_container/tiles_container.viewgroup.dart';
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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is FetchAllLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is FetchAllComplete) {
          return SingleChildScrollView(
            child: Column(
              children: [
                state.response.success['tiles'] != null &&
                        state.response.success['tiles']!
                    ? TilesContainer(
                        list: state.response.result['tiles'] != null
                            ? state.response.result['tiles']!
                            : [],
                      )
                    : ListError(
                        errorMessage: state.response.error['tiles'] != null
                            ? state.response.error['tiles']!
                            : 'Something went wrong!',
                      ),
                state.response.success['oldest_items'] != null &&
                        state.response.success['oldest_items']!
                    ? ItemsList(
                        listTitle: 'Oldest Items',
                        list: state.response.result['oldest_items'] != null
                            ? state.response.result['oldest_items']!
                            : [],
                        navigateTo: Traits.none,
                      )
                    : ListError(
                        errorMessage:
                            state.response.error['oldest_items'] != null
                                ? state.response.error['oldest_items']!
                                : 'Something went wrong!',
                      ),
                state.response.success['favorites'] != null &&
                        state.response.success['favorites']!
                    ? ItemsList(
                        listTitle: 'Favorites',
                        list: state.response.result['favorites'] != null
                            ? state.response.result['favorites']!
                            : [],
                        navigateTo: Traits.favorites,
                      )
                    : ListError(
                        errorMessage: state.response.error['favorites'] != null
                            ? state.response.error['favorites']!
                            : 'Something went wrong!',
                      ),
                state.response.success['latest_items'] != null &&
                        state.response.success['latest_items']!
                    ? ItemsList(
                        listTitle: 'Latest Items',
                        list: state.response.result['latest_items']
                            ? state.response.result['latest_items']!
                            : [],
                        navigateTo: Traits.none,
                      )
                    : ListError(
                        errorMessage:
                            state.response.error['latest_items'] != null
                                ? state.response.error['latest_items']!
                                : 'Something went wrong!',
                      ),
                state.response.success['most_tagged'] != null &&
                        state.response.success['most_tagged']!
                    ? ItemsList(
                        listTitle: 'Most Tagged',
                        list: state.response.result['most_tagged'] != null
                            ? state.response.result['most_tagged']!
                            : [],
                        navigateTo: Traits.none,
                      )
                    : ListError(
                        errorMessage:
                            state.response.error['most_tagged'] != null
                                ? state.response.error['most_tagged']!
                                : 'Something went wrong!',
                      ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
