import 'package:flutter/material.dart';
import 'package:whereisit/models/multi_select_dropdown_data.model.dart';

class MultiSelectDropdown extends StatefulWidget {
  const MultiSelectDropdown({Key? key}) : super(key: key);

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  // The below ignore is accepted as we are changing the values later.
  // Ref: https://dart-lang.github.io/linter/lints/prefer_final_fields.html
  // ignore: prefer_final_fields
  var _list = [
    MultiSelectDropdownData("1", false, "tagOne"),
    MultiSelectDropdownData("2", false, "tagTwo"),
    MultiSelectDropdownData("3", false, "tagThree"),
    MultiSelectDropdownData("4", false, "tagFour"),
    MultiSelectDropdownData("5", false, "tagFive"),
  ];
  var _selectedItems = "";
  var _showDropdown = false;
  var _selected = [];

  _handleCheckboxToggle(int index, bool status) {
    setState(() {
      _list[index].isSelected = status;

      if (_selectedItems.isEmpty) {
        _selectedItems = '${_list[index].value}, ';
      } else if (status) {
        _selectedItems = '$_selectedItems, ${_list[index].value}';
      } else {
        var _selectedItem = _list[index].value;
        var _lastItem = _selectedItems.substring(
            _selectedItems.length - _selectedItem.length,
            _selectedItems.length);

        if (_lastItem == _selectedItem) {
          _selectedItems.replaceAll(', ${_list[index].value}', '');
        } else {
          _selectedItems.replaceAll('${_list[index].value}, ', '');
        }
      }
    });
  }

  _buildList() {
    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: ((context, index) {
        return Row(
          children: [
            Checkbox(
              value: _list[index].isSelected,
              onChanged: (bool? value) {
                _handleCheckboxToggle(index, value!);
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
