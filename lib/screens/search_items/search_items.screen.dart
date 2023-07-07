import 'package:flutter/material.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';
import 'package:whereisit/screens/search_with_dropdown/search_with_dropdown.screen.dart';

class SearchItemsScreen extends StatelessWidget {
  static const routeName = '/search-items';

  const SearchItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      action: AppBarAction.searchItem,
      body: SearchWithDropdownScreen(),
    );
  }
}
