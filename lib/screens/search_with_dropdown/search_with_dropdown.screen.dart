import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/search_with_dropdown/swd_item_property/swd_item_property_handler.viewgroup.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/enums/search_type.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';
import 'package:whereisit/screens/search_with_dropdown/swd_item_address/swd_item_address_handler.viewgroup.dart';
import 'package:whereisit/screens/search_with_dropdown/swd_item_list_handler/swd_item_list_handler.viewgroup.dart';
import 'package:whereisit/screens/search_with_dropdown/swd_tag_handler/swd_tag_handler.viewgroup.dart';

class SearchWithDropdownScreen extends StatelessWidget {
  static const routeName = '/search-with-dropdown';

  const SearchWithDropdownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    var searchType = SearchType.none;

    if (args != null && args is SearchType) {
      searchType = args;
    }

    if (searchType == SearchType.searchAddress) {
      return WillPopScope(
        onWillPop: () async {
          BlocProvider.of<EditItemBloc>(context).add(
            EditItemAddressSelectIgnore(),
          );
          return true;
        },
        child: const AppScaffold(
          action: AppBarAction.searchItem,
          body: SwdItemAddressHandler(),
        ),
      );
    } else if (searchType == SearchType.searchItem) {
      return const AppScaffold(
        action: AppBarAction.searchItem,
        body: SwdItemListHandler(),
      );
    } else if (searchType == SearchType.searchProperty) {
      return WillPopScope(
        onWillPop: () async {
          BlocProvider.of<EditItemBloc>(context).add(
            EditItemPropertySelectIgnore(),
          );
          return true;
        },
        child: const AppScaffold(
          action: AppBarAction.searchProperty,
          body: SwdItemPropertyHandler(),
        ),
      );
    } else if (searchType == SearchType.searchTag) {
      BlocProvider.of<EditItemBloc>(context).add(EditItemTagInitial());
      return WillPopScope(
        onWillPop: () async {
          BlocProvider.of<EditItemBloc>(context).add(
            EditItemTagSelectIgnore(),
          );
          return true;
        },
        child: const AppScaffold(
          action: AppBarAction.searchTag,
          body: SwdTagHandler(),
        ),
      );
    }

    return const Center(child: Text('Something went wrong!'));
  }
}
