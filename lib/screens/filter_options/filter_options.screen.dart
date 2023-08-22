import 'package:flutter/material.dart';
import 'package:whereisit/screens/filter_options/filter_accordian/filter_accordian.view.dart';
import 'package:whereisit/shared/intents/route_arguments.intent.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';

class FilterOptions extends StatelessWidget {
  static const routeName = '/filter-options';

  const FilterOptions({Key? key}) : super(key: key);

  List<Widget> _buildFavoritesFilter() {
    return [
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    var fromFavorites = false;

    if (args != null) {
      args = args as RouteArguments;
      var params = args.params as Map<String, bool>;
      fromFavorites = params['fromFavorites']!;
    }

    return AppScaffold(
      title: 'Filter favorite items',
      body: Column(
        children: [
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
          if (!fromFavorites) ..._buildFavoritesFilter(),
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
      ),
    );
  }
}
