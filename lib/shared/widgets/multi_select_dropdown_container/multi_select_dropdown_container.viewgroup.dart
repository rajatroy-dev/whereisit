import 'package:flutter/material.dart';
import 'package:whereisit/models/multi_select_dropdown_data.model.dart';
import 'package:whereisit/shared/widgets/multi_select_dropdown_container/multi_select_dropdown_list.view.dart';

class MultiSelectDropdownContainer extends StatefulWidget {
  final double width;
  final double padding;

  const MultiSelectDropdownContainer({
    Key? key,
    this.width = double.infinity,
    this.padding = 5,
  })  : assert(padding >= 5, 'Minimum padding is 5.'),
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
    MultiSelectDropdownData('6', false, 'tagSix'),
    MultiSelectDropdownData('7', false, 'tagSeven'),
    MultiSelectDropdownData('8', false, 'tagEight'),
  ];
  var _listCopy = <MultiSelectDropdownData>[];
  var _selectedItems = '';
  var _selectedItemsCopy = '';
  var _showDropdown = false;

  _handleDropdownToggle() {
    var temp = <MultiSelectDropdownData>[];
    for (var element in _list) {
      temp.add(MultiSelectDropdownData.copyWith(
          element.id, element.isSelected, element.value));
    }
    setState(() {
      if (!_showDropdown) {
        _selectedItemsCopy = _selectedItems;
        _listCopy = temp;
      }
      _showDropdown = true;
    });
  }

  _handleCheckboxToggle(int index, bool checkValue) {
    setState(() {
      _listCopy[index].isSelected = checkValue;

      if (_selectedItemsCopy.isEmpty) {
        _selectedItemsCopy = _listCopy[index].value;
      } else if (checkValue) {
        _selectedItemsCopy = '$_selectedItemsCopy, ${_listCopy[index].value}';
      } else if (!_selectedItemsCopy.contains(',')) {
        _selectedItemsCopy = '';
      } else {
        var _selectedItem = _listCopy[index].value;
        var _lastItem = _selectedItemsCopy.substring(
            _selectedItemsCopy.length - _selectedItem.length,
            _selectedItemsCopy.length);

        if (_lastItem == _selectedItem) {
          _selectedItemsCopy =
              _selectedItemsCopy.replaceAll(', ${_listCopy[index].value}', '');
        } else {
          _selectedItemsCopy =
              _selectedItemsCopy.replaceAll('${_listCopy[index].value}, ', '');
        }
      }
    });
  }

  _handleDropdownCancel() {
    setState(() {
      _listCopy = [];
      _selectedItemsCopy = '';
      _showDropdown = false;
    });
  }

  _handleDropdownOk() {
    setState(() {
      _selectedItems = _selectedItemsCopy;
      _selectedItemsCopy = '';
      _list = _listCopy;
      _listCopy = [];
      _showDropdown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: widget.padding,
        left: widget.padding,
        right: widget.padding,
      ),
      width: widget.width,
      child: Stack(
        children: [
          GestureDetector(
            onTap: _handleDropdownToggle,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: Colors.purple),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      _showDropdown ? _selectedItemsCopy : _selectedItems,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _showDropdown
                      ? const Icon(Icons.arrow_drop_up_rounded)
                      : const Icon(Icons.arrow_drop_down_rounded),
                ],
              ),
            ),
          ),
          if (_showDropdown)
            MultiSelectDropdownList(
              list: _showDropdown ? _listCopy : _list,
              checkboxHandler: _handleCheckboxToggle,
              okHandler: _handleDropdownOk,
              cancelHandler: _handleDropdownCancel,
            ),
        ],
      ),
    );
  }
}
