import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/search_type.enum.dart';
import 'package:whereisit/shared/widgets/search_with_dropdown/swd_item_list_handler/swd_item_list_handler.viewgroup.dart';
import 'package:whereisit/shared/widgets/search_with_dropdown/swd_tag_handler/swd_tag_handler.viewgroup.dart';

class SearchWithDropdown extends StatefulWidget {
  static const routeName = '/search-with-dropdown';

  final SearchType searchType;

  const SearchWithDropdown({
    Key? key,
    required this.searchType,
  }) : super(key: key);

  @override
  State<SearchWithDropdown> createState() => _SearchWithDropdownState();
}

class _SearchWithDropdownState extends State<SearchWithDropdown> {
  @override
  void initState() {
    if (widget.searchType == SearchType.searchTag) {
      BlocProvider.of<EditItemBloc>(context).add(EditItemTagInitial());
    }
    // TODO: Handle Initialization of SearchItem
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.searchType == SearchType.searchTag) {
      return const SwdTagHandler();
    } else if (widget.searchType == SearchType.searchTag) {
      return const SwdItemListHandler();
    }

    return const Center(child: Text('Something went wrong!'));
  }
}
