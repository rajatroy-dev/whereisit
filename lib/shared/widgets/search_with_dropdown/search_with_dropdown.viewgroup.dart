import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/enums/search_type.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';
import 'package:whereisit/shared/widgets/search_with_dropdown/swd_item_address/swd_item_address.viewgroup.dart';
import 'package:whereisit/shared/widgets/search_with_dropdown/swd_item_list_handler/swd_item_list_handler.viewgroup.dart';
import 'package:whereisit/shared/widgets/search_with_dropdown/swd_tag_handler/swd_tag_handler.viewgroup.dart';

class SearchWithDropdown extends StatelessWidget {
  static const routeName = '/search-with-dropdown';

  const SearchWithDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    var searchType = SearchType.none;

    if (args != null && args is SearchType) {
      searchType = args;
    }

    if (searchType == SearchType.searchAddress) {
      return const AppScaffold(
        action: AppBarAction.searchItem,
        body: SwdItemAddress(),
      );
    } else if (searchType == SearchType.searchItem) {
      return const AppScaffold(
        action: AppBarAction.searchItem,
        body: SwdItemListHandler(),
      );
    } else if (searchType == SearchType.searchTag) {
      BlocProvider.of<EditItemBloc>(context).add(EditItemTagInitial());
      return const AppScaffold(
        action: AppBarAction.searchTag,
        body: SwdTagHandler(),
      );
    }

    return const Center(child: Text('Something went wrong!'));
  }
}
