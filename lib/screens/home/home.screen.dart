import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:whereisit/screens/home/cubit/home_cubit.dart';
import 'package:whereisit/screens/home/items_list/items_list.viewgroup.dart';
import 'package:whereisit/screens/home/tiles_container/tiles_container.viewgroup.dart';
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
          return Column(
            children: [
              state.response.success['tiles']!
                  ? TilesContainer(list: state.response.result['tiles']!)
                  : ListError(errorMessage: state.response.error['tiles']!),
              state.response.success['oldest_items']!
                  ? ItemsList(
                      listTitle: 'Oldest Items',
                      list: state.response.result['oldest_items']!,
                      navigateTo: '',
                    )
                  : ListError(
                      errorMessage: state.response.error['oldest_items']!,
                    ),
              state.response.success['favorites']!
                  ? ItemsList(
                      listTitle: 'Favorites',
                      list: state.response.result['favorites']!,
                      navigateTo: '',
                    )
                  : ListError(
                      errorMessage: state.response.error['favorites']!,
                    ),
              state.response.success['latest_items']!
                  ? ItemsList(
                      listTitle: 'Latest Items',
                      list: state.response.result['latest_items']!,
                      navigateTo: '',
                    )
                  : ListError(
                      errorMessage: state.response.error['latest_items']!,
                    ),
              state.response.success['most_tagged']!
                  ? ItemsList(
                      listTitle: 'Most Tagged',
                      list: state.response.result['most_tagged']!,
                      navigateTo: '',
                    )
                  : ListError(
                      errorMessage: state.response.error['most_tagged']!,
                    ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
