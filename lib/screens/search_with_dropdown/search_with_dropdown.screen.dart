import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/models/tag.model.dart';
import 'package:whereisit/screens/search_with_dropdown/dropdown_list.view.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/enums/appbar_action.enum.dart';
import 'package:whereisit/shared/widgets/app_scaffold/app_scaffold.viewgroup.dart';

class SearchWithDropdownScreen extends StatefulWidget {
  static const routeName = '/search-with-dropdown';
  const SearchWithDropdownScreen({Key? key}) : super(key: key);

  @override
  State<SearchWithDropdownScreen> createState() =>
      _SearchWithDropdownScreenState();
}

class _SearchWithDropdownScreenState extends State<SearchWithDropdownScreen> {
  final _controller = TextEditingController();
  var showDropdown = false;

  @override
  void initState() {
    BlocProvider.of<EditItemBloc>(context).add(EditItemTagInitial());
    super.initState();
  }

  InputDecoration decoration = InputDecoration(
    border: const OutlineInputBorder(),
    hintText: 'Search . . .',
    suffixIcon: IconButton(
      onPressed: () {},
      icon: const Icon(Icons.arrow_drop_down_rounded),
    ),
  );

  InputDecoration _inputCrossDecoration() {
    return InputDecoration(
      border: const OutlineInputBorder(),
      hintText: 'Search . . .',
      suffixIcon: IconButton(
        onPressed: handleSuffixTap,
        icon: const Icon(Icons.clear_rounded),
      ),
    );
  }

  InputDecoration _inputArrowDecoration() {
    return InputDecoration(
      border: const OutlineInputBorder(),
      hintText: 'Search . . .',
      suffixIcon: IconButton(
        onPressed: handleSuffixTap,
        icon: const Icon(Icons.arrow_drop_down_rounded),
      ),
    );
  }

  handleInputChange(String value) {
    if (value.isNotEmpty) {
      // var temp = [...list];
      // var exact = false;

      // temp = temp.where((i) {
      //   var iInLowerCase = i.item.toLowerCase();
      //   var valueInLowerCase = value.toLowerCase();
      //   if (!exact) {
      //     exact = iInLowerCase == valueInLowerCase;
      //   }
      //   return iInLowerCase.contains(valueInLowerCase);
      // }).toList();

      // if (!exact) {
      //   temp.insert(
      //     0,
      //     ListItem(
      //       isNew: true,
      //       item: '+ Add "$value" to list',
      //       value: value,
      //     ),
      //   );
      // }

      setState(() {
        decoration = _inputCrossDecoration();
        showDropdown = true;
      });
      return;
    }

    setState(() {
      decoration = _inputArrowDecoration();
      showDropdown = false;
    });
  }

  handleSuffixTap() {
    if (_controller.text.isNotEmpty) {
      _controller.clear();
      setState(() {
        decoration = _inputArrowDecoration();
        showDropdown = false;
      });
      return;
    }

    setState(() {
      showDropdown = !showDropdown;
    });
  }

  handleAddToList(String value) {
    // var temp = [...list];
    // temp.insert(0, ListItem(isNew: false, item: value));
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
    return AppScaffold(
      action: AppBarAction.searchTag,
      body: SingleChildScrollView(
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
                    var count = state.selectedTagCount;
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
      ),
    );
  }
}
