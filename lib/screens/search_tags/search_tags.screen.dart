import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/shared/enums/search_type.enum.dart';
import 'package:whereisit/screens/search_with_dropdown/search_with_dropdown.screen.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';

class SearchTagsScreen extends StatefulWidget {
  const SearchTagsScreen({Key? key}) : super(key: key);

  @override
  State<SearchTagsScreen> createState() => _SearchTagsScreenState();
}

class _SearchTagsScreenState extends State<SearchTagsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: Separate out logic from SearchWithDropdown to SearTagsScreen and SearchItemsScreen
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<EditItemBloc>(context).add(
          EditItemTagSelectIgnore(),
        );
        return true;
      },
      child: const AppScaffold(
        action: AppBarAction.searchTag,
        body: SearchWithDropdownScreen(),
      ),
    );
  }
}
