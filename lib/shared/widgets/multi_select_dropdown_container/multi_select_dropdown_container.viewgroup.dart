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
  var _selectedItems = '';
  var _itemsRecordForCancel = '';
  Map<int, bool> _indexRecordForCancel = {};
  var _selectedItemsCount = 0;
  var _showDropdown = false;

  _handleDropdownToggle() {
    setState(() {
      if (!_showDropdown) {
        _itemsRecordForCancel = _selectedItems;
      }
      _showDropdown = true;
    });
  }

  _handleCheckboxToggle(int index, bool checkValue) {
    setState(() {
      _list[index].isSelected = checkValue;

      if (_itemsRecordForCancel.isEmpty) {
        _itemsRecordForCancel = _list[index].value;
        _indexRecordForCancel[index] = true;
        _selectedItemsCount++;
      } else if (checkValue) {
        _itemsRecordForCancel = '$_itemsRecordForCancel, ${_list[index].value}';
        _indexRecordForCancel[index] = true;
        _selectedItemsCount++;
      } else if (_selectedItemsCount == 1) {
        _itemsRecordForCancel = '';
        _indexRecordForCancel[index] = false;
        _selectedItemsCount--;
      } else {
        var _selectedItem = _list[index].value;
        var _lastItem = _itemsRecordForCancel.substring(
            _itemsRecordForCancel.length - _selectedItem.length,
            _itemsRecordForCancel.length);

        if (_lastItem == _selectedItem) {
          _itemsRecordForCancel =
              _itemsRecordForCancel.replaceAll(', ${_list[index].value}', '');
        } else {
          _itemsRecordForCancel =
              _itemsRecordForCancel.replaceAll('${_list[index].value}, ', '');
        }
        _indexRecordForCancel[index] = false;
        _selectedItemsCount--;
      }
    });
  }

  _handleDropdownCancel() {
    var temp = _list;
    _indexRecordForCancel
        .forEach((key, value) => temp[key].isSelected = !value);

    setState(() {
      _list = temp;
      _showDropdown = false;
    });
  }

  _handleDropdownOk() {
    setState(() {
      _selectedItems = _itemsRecordForCancel;
      _itemsRecordForCancel = '';
      _indexRecordForCancel = {};
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
                      _showDropdown ? _itemsRecordForCancel : _selectedItems,
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
              list: _list,
              checkboxHandler: _handleCheckboxToggle,
              okHandler: _handleDropdownOk,
              cancelHandler: _handleDropdownCancel,
            ),
        ],
      ),
    );
  }
}
