import 'package:flutter/material.dart';
import 'package:whereisit/models/multi_select_dropdown_data.model.dart';

class MultiSelectDropdown extends StatefulWidget {
  const MultiSelectDropdown({Key? key}) : super(key: key);

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  late List<MultiSelectDropdownData> _list = [
    MultiSelectDropdownData("1", false, "tagOne"),
    MultiSelectDropdownData("2", false, "tagTwo"),
    MultiSelectDropdownData("3", false, "tagThree"),
    MultiSelectDropdownData("4", false, "tagFour"),
    MultiSelectDropdownData("5", false, "tagFive"),
  ];

  late String _selectedItems = "";
  late bool _showDropdown = false;
  late List<MultiSelectDropdown> _selected = [];

  _buildList() {
    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: ((context, index) {
        return Row(
          children: [
            Checkbox(
              value: _list[index].isSelected,
              onChanged: (bool? value) {
                setState(() {
                  _list[index].isSelected = value!;
                });
              },
            ),
            Text(_list[index].value),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(_selectedItems),
          _buildList(),
        ],
      ),
    );
  }
}
