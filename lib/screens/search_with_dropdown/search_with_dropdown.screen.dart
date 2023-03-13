import 'package:flutter/material.dart';
import 'package:whereisit/screens/search_with_dropdown/dropdown_list.view.dart';
import 'package:whereisit/shared/widgets/app_scaffold.viewgroup.dart';

class SearchWithDropdownScreen extends StatefulWidget {
  const SearchWithDropdownScreen({Key? key}) : super(key: key);

  @override
  State<SearchWithDropdownScreen> createState() =>
      _SearchWithDropdownScreenState();
}

class _SearchWithDropdownScreenState extends State<SearchWithDropdownScreen> {
  final _textController = TextEditingController();
  final list = [
    'Alaskan Malamute',
    'Bohemian Shepherd',
    'Cane Corso',
    'Dobermann',
    'English Mastiff',
    'Finnish Hound',
    'Great Dane'
  ];

  List<String> filtered = [];
  var showDropdown = false;

  @override
  void initState() {
    filtered = list;
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

  InputDecoration _inputClearDecoration() {
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
      temp = temp.where((i) => i.toLowerCase().contains(value)).toList();

      setState(() {
        decoration = _inputClearDecoration();
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
    if (_textController.text.isNotEmpty) {
      _textController.clear();
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

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _textController,
                onChanged: handleInputChange,
                decoration: _textController.text.isNotEmpty
                    ? _inputClearDecoration()
                    : _inputArrowDecoration(),
              ),
              if (showDropdown) DropdownList(list: filtered),
            ],
          ),
        ),
      ),
    );
  }
}
