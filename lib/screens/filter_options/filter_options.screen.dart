import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/filter_options/bloc/filter_options_bloc.dart';
import 'package:whereisit/screens/filter_options/filter_accordian/filter_accordian.view.dart';
import 'package:whereisit/shared/intents/route_arguments.intent.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';

class FilterOptions extends StatelessWidget {
  static const routeName = '/filter-options';

  const FilterOptions({Key? key}) : super(key: key);

  Widget _buildFilterOptionsForFavorites() {
    return BlocBuilder<FilterOptionsBloc, FilterOptionsState>(
      buildWhen: (previous, current) => current is FilterOptionsLoadSuccess,
      builder: (context, state) {
        if (state is FilterOptionsLoadSuccess) {
          var categories = state.filterOptions['categories'] as List<int>;
          var locations = state.filterOptions['locations'] as List<int>;
          var properties = state.filterOptions['properties'] as List<int>;
          var rooms = state.filterOptions['rooms'] as List<int>;
          var tags = state.filterOptions['tags'] as List<int>;

          return Column(
            children: [
              // TODO: handle empty filter criteria
              if (properties.isNotEmpty)
                FilterAccordian(
                  title: 'Property',
                  content: [
                    'ABC',
                    'DEF',
                    'GHI',
                  ],
                ),
              if (locations.isNotEmpty)
                FilterAccordian(
                  title: 'Area',
                  content: [
                    'ABC',
                    'DEF',
                    'GHI',
                  ],
                ),
              if (rooms.isNotEmpty)
                FilterAccordian(
                  title: 'Room',
                  content: [
                    'ABC',
                    'DEF',
                    'GHI',
                  ],
                ),
              if (tags.isNotEmpty)
                FilterAccordian(
                  title: 'Tags',
                  content: [
                    'ABC',
                    'DEF',
                    'GHI',
                  ],
                ),
              if (categories.isNotEmpty)
                FilterAccordian(
                  title: 'Category',
                  content: [
                    'ABC',
                    'DEF',
                    'GHI',
                  ],
                ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildFilterOptions() {
    return Column(
      children: [
        // TODO: handle empty filter criteria
        FilterAccordian(
          title: 'Property',
          content: [
            'ABC',
            'DEF',
            'GHI',
          ],
        ),
        FilterAccordian(
          title: 'Area',
          content: [
            'ABC',
            'DEF',
            'GHI',
          ],
        ),
        FilterAccordian(
          title: 'Room',
          content: [
            'ABC',
            'DEF',
            'GHI',
          ],
        ),
        const Text("Favorite"),
        Row(
          children: [
            const Text("Yes"),
            Checkbox(
              value: true,
              onChanged: (bool? value) {},
            ),
            const Text("No"),
            Checkbox(
              value: false,
              onChanged: (bool? value) {},
            ),
          ],
        ),
        FilterAccordian(
          title: 'Tags',
          content: [
            'ABC',
            'DEF',
            'GHI',
          ],
        ),
        FilterAccordian(
          title: 'Address',
          content: [
            'ABC',
            'DEF',
            'GHI',
          ],
        ),
        FilterAccordian(
          title: 'Category',
          content: [
            'ABC',
            'DEF',
            'GHI',
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    var fromFavorites = false;

    if (args != null) {
      args = args as RouteArguments;
      fromFavorites = args.params!['fromFavorites'] as bool;
    }

    if (fromFavorites) {
      BlocProvider.of<FilterOptionsBloc>(context).add(FilterOptionsLoad());
    }

    return AppScaffold(
      title: 'Filter favorite items',
      body: fromFavorites
          ? _buildFilterOptionsForFavorites()
          : _buildFilterOptions(),
    );
  }
}
