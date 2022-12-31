import 'package:flutter/material.dart';
import 'package:whereisit/models/multi_select_dropdown_data.model.dart';
import 'package:whereisit/shared/widgets/multi_select_dropdown_container/multi_select_dropdown_list.view.dart';

class MultiSelectDropdownContainer extends StatefulWidget {
  final double height;
  final double width;

  const MultiSelectDropdownContainer({
    Key? key,
    this.height = 350,
    this.width = double.infinity,
  })  : assert(
            height >= 350,
            'The height of the multi-select dropdown '
            'must be greater than 200.'),
        super(key: key);

  @override
  State<MultiSelectDropdownContainer> createState() =>
      _MultiSelectDropdownContainerState();
}

class _MultiSelectDropdownContainerState
    extends State<MultiSelectDropdownContainer> {
  // The below ignore is accepted as we are changing the values later.
  // Ref: https://dart-lang.github.io/linter/lints/prefer_final_fields.html
  // ignore: prefer_final_fields
  var _list = [
    MultiSelectDropdownData('1', false, 'tagOne'),
    MultiSelectDropdownData('2', false, 'tagTwo'),
    MultiSelectDropdownData('3', false, 'tagThree'),
    MultiSelectDropdownData('4', false, 'tagFour'),
    MultiSelectDropdownData('5', false, 'tagFive'),
  ];
  var _selectedItems = '';
  var _selectedItemsCount = 0;
  var _showDropdown = false;
  var _selected = [];

  _handleCheckboxToggle(int index, bool checkValue) {
    setState(() {
      _list[index].isSelected = checkValue;

      if (_selectedItems.isEmpty) {
        _selectedItems = _list[index].value;
        _selectedItemsCount++;
      } else if (checkValue) {
        _selectedItems = '$_selectedItems, ${_list[index].value}';
        _selectedItemsCount++;
      } else if (_selectedItemsCount == 1) {
        _selectedItems = '';
        _selectedItemsCount--;
      } else {
        var _selectedItem = _list[index].value;
        var _lastItem = _selectedItems.substring(
            _selectedItems.length - _selectedItem.length,
            _selectedItems.length);

        if (_lastItem == _selectedItem) {
          _selectedItems =
              _selectedItems.replaceAll(', ${_list[index].value}', '');
        } else {
          _selectedItems =
              _selectedItems.replaceAll('${_list[index].value}, ', '');
        }
        _selectedItemsCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Column(
        children: [
          Text(_selectedItems),
          MultiSelectDropdownList(
            height: 300,
            width: widget.width,
            list: _list,
            checkboxHandler: _handleCheckboxToggle,
          ),
        ],
      ),
    );
  }
}
