import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/models/list_item.model.dart';
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
  var list = [
    ListItem(isNew: false, item: 'Alaskan Malamute'),
    ListItem(isNew: false, item: 'Bohemian Shepherd'),
    ListItem(isNew: false, item: 'Cane Corso'),
    ListItem(isNew: false, item: 'Dobermann'),
    ListItem(isNew: false, item: 'English Mastiff'),
    ListItem(isNew: false, item: 'Finnish Hound'),
    ListItem(isNew: false, item: 'Great Dane'),
  ];

  List<ListItem> filtered = [];
  var showDropdown = false;

  @override
  void initState() {
    filtered = list;
    BlocProvider.of<EditItemBloc>(context).add(EditItemTagsInitial());
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
      var temp = [...list];
      var exact = false;

      temp = temp.where((i) {
        var iInLowerCase = i.item.toLowerCase();
        var valueInLowerCase = value.toLowerCase();
        if (!exact) {
          exact = iInLowerCase == valueInLowerCase;
        }
        return iInLowerCase.contains(valueInLowerCase);
      }).toList();

      if (!exact) {
        temp.insert(
          0,
          ListItem(
            isNew: true,
            item: '+ Add "$value" to list',
            value: value,
          ),
        );
      }

      setState(() {
        decoration = _inputCrossDecoration();
        showDropdown = true;
        filtered = temp;
      });
      return;
    }

    setState(() {
      decoration = _inputArrowDecoration();
      showDropdown = false;
      filtered = list;
    });
  }

  handleSuffixTap() {
    if (_controller.text.isNotEmpty) {
      _controller.clear();
      setState(() {
        decoration = _inputArrowDecoration();
        showDropdown = false;
        filtered = list;
      });
      return;
    }

    setState(() {
      showDropdown = !showDropdown;
    });
  }

  handleAddToList(String value) {
    var temp = [...list];
    temp.insert(0, ListItem(isNew: false, item: value));
    setState(() {
      list = temp;
      filtered = list;
      showDropdown = false;
    });
  }

  handleSelect(String value) {
    _controller.text = value;
    setState(() {
      filtered = list;
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
              TextField(
                controller: _controller,
                onChanged: handleInputChange,
                decoration: _controller.text.isNotEmpty
                    ? _inputCrossDecoration()
                    : _inputArrowDecoration(),
              ),
              if (showDropdown)
                DropdownList(
                  list: filtered,
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
