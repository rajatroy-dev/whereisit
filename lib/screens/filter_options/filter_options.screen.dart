import 'package:flutter/material.dart';
import 'package:whereisit/screens/category_subcategory/accordian/category_subcategory_accordian.view.dart';
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
      fromFavorites = args.params!['fromFavorites'] as bool;
    }

    return AppScaffold(
      body: Column(
        children: [
          const Text("Filter By"),
          CategorySubcategoryAccordian(
            title: 'Property',
            content: [
              'ABC',
              'DEF',
              'GHI',
            ],
          ),
          const Text("Property"),
          const Text("Area"),
          const Text("Room"),
          if (!fromFavorites) ..._buildFavoritesFilter(),
          const Text("Tags"),
          Row(
            children: [
              const Text("#abc"),
              Checkbox(
                value: true,
                onChanged: (bool? value) {},
              ),
              const Text("#def"),
              Checkbox(
                value: false,
                onChanged: (bool? value) {},
              ),
              const Text("#ghi"),
              Checkbox(
                value: false,
                onChanged: (bool? value) {},
              ),
              const Text("#jkl"),
              Checkbox(
                value: false,
                onChanged: (bool? value) {},
              ),
            ],
          ),
          const Text("Map Location"),
        ],
      ),
    );
  }
}
