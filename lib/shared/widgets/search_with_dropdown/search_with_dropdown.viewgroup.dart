import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/shared/widgets/search_with_dropdown/swd_tag_handler/dropdown_list.view.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';

class SearchWithDropdown extends StatefulWidget {
  static const routeName = '/search-with-dropdown';
  const SearchWithDropdown({Key? key}) : super(key: key);

  @override
  State<SearchWithDropdown> createState() => _SearchWithDropdownState();
}

class _SearchWithDropdownState extends State<SearchWithDropdown> {
  final _controller = TextEditingController();
  var showDropdown = false;

  @override
  void initState() {
    BlocProvider.of<EditItemBloc>(context).add(EditItemTagInitial());
    super.initState();
  }

  handleAddToList(String value) {
    setState(() {
      showDropdown = false;
    });
  }

  handleSelect(String value) {
    _controller.text = value;
    setState(() {
      showDropdown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<EditItemBloc, EditItemState>(
              buildWhen: (_, currentState) =>
                  currentState is EditItemTagsOnSelectionCountUpdateSuccess,
              builder: (context, state) {
                if (state is EditItemTagsOnSelectionCountUpdateSuccess) {
                  var count = state.item.uiTagCount;
                  var tagOrtags = count == 1 ? 'tag' : 'tags';
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    child: Text('${count.toString()} $tagOrtags selected'),
                  );
                }
                return const SizedBox();
              },
            ),
            DropdownList(
              handleNew: handleAddToList,
              handleSelect: handleSelect,
            ),
          ],
        ),
      ),
    );
  }
}