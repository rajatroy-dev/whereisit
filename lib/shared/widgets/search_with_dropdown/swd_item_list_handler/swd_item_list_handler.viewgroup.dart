import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/screens/search_items/bloc/search_items_bloc.dart';

class SwdItemListHandler extends StatefulWidget {
  const SwdItemListHandler({Key? key}) : super(key: key);

  @override
  State<SwdItemListHandler> createState() => _SwdItemListHandlerState();
}

class _SwdItemListHandlerState extends State<SwdItemListHandler> {
  final _controller = TextEditingController();
  var showDropdown = false;

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
            BlocBuilder<SearchItemsBloc, SearchItemsState>(
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
            TagDropdownList(
              handleNew: handleAddToList,
              handleSelect: handleSelect,
            ),
          ],
        ),
      ),
    );
  }
}
