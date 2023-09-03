import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/filter_options/bloc/filter_options_bloc.dart';
import 'package:whereisit/screens/filter_options/filter_accordian/filter_accordian.view.dart';
import 'package:whereisit/shared/enums/available_filters.enum.dart';
import 'package:whereisit/shared/intents/route_arguments.intent.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';

class FilterOptions extends StatelessWidget {
  static const routeName = '/filter-options';

  const FilterOptions({Key? key}) : super(key: key);

  Widget _buildFilterOptionsForFavorites() {
    return BlocBuilder<FilterOptionsBloc, FilterOptionsState>(
      buildWhen: (previous, current) =>
          current is FilterOptionsLoadForFavoritesSuccess,
      builder: (context, state) {
        if (state is FilterOptionsLoadForFavoritesSuccess) {
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
                  filterType: AvailableFilters.property,
                  title: 'Property',
                  content: properties,
                ),
              if (locations.isNotEmpty)
                FilterAccordian(
                  filterType: AvailableFilters.location,
                  title: 'Area',
                  content: locations,
                ),
              if (rooms.isNotEmpty)
                FilterAccordian(
                  filterType: AvailableFilters.room,
                  title: 'Room',
                  content: rooms,
                ),
              if (tags.isNotEmpty)
                FilterAccordian(
                  filterType: AvailableFilters.tags,
                  title: 'Tags',
                  content: tags,
                ),
              if (categories.isNotEmpty)
                FilterAccordian(
                  filterType: AvailableFilters.category,
                  title: 'Category',
                  content: categories,
                ),
            ],
          );
        }

        if (state is FilterOptionsLoadFailure) {
          return const Center(
            child: Text('Something Went Wrong!'),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildFilterOptions() {
    bool? _isfavorite = true;

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
              FilterAccordian(
                filterType: AvailableFilters.property,
                title: 'Property',
                content: properties,
              ),
              FilterAccordian(
                filterType: AvailableFilters.location,
                title: 'Area',
                content: locations,
              ),
              FilterAccordian(
                filterType: AvailableFilters.room,
                title: 'Room',
                content: rooms,
              ),
              const Text("Favorite"),
              Row(
                children: [
                  Radio(
                    value: true,
                    groupValue: _isfavorite,
                    onChanged: (bool? value) {
                      _isfavorite = value ?? false;
                    },
                  ),
                  const Text("Yes"),
                  Radio(
                    value: false,
                    groupValue: _isfavorite,
                    onChanged: (bool? value) {
                      _isfavorite = value ?? false;
                    },
                  ),
                  const Text("No"),
                ],
              ),
              FilterAccordian(
                filterType: AvailableFilters.tags,
                title: 'Tags',
                content: tags,
              ),
              FilterAccordian(
                filterType: AvailableFilters.category,
                title: 'Category',
                content: categories,
              ),
            ],
          );
        }

        if (state is FilterOptionsLoadFailure) {
          return const Center(
            child: Text('Something Went Wrong!'),
          );
        }

        return const SizedBox();
      },
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
      BlocProvider.of<FilterOptionsBloc>(context).add(
        FilterOptionsLoadForFavorites(),
      );
    } else {
      BlocProvider.of<FilterOptionsBloc>(context).add(
        FilterOptionsLoad(),
      );
    }

    return AppScaffold(
      title: 'Filter favorite items',
      body: fromFavorites
          ? _buildFilterOptionsForFavorites()
          : _buildFilterOptions(),
    );
  }
}
