import 'package:flutter/material.dart';
import 'package:whereisit/shared/widgets/select_dropdown_container/select_dropdown_list.view.dart';

class SelectDropdownContainer extends StatefulWidget {
  final double padding;
  final String title;

  const SelectDropdownContainer({
    Key? key,
    this.padding = 5,
    this.title = "Select an item",
  })  : assert(padding >= 5, 'Minimum padding is 5.'),
        super(key: key);

  @override
  State<SelectDropdownContainer> createState() =>
      _SelectDropdownContainerState();
}

class _SelectDropdownContainerState extends State<SelectDropdownContainer> {
  // ignore: prefer_final_fields
  var _showDropdown = false;
  // ignore: prefer_final_fields
  var _list = <String>[
    'ItemA',
    'ItemB',
    'ItemC',
    'ItemD',
    'ItemE',
    'ItemF',
    'ItemG',
    'ItemH',
    'ItemI',
  ];
  var _selectedItem = '';
  var _selectedItemCopy = '';

  void _handleDropdown() {
    setState(() {
      _selectedItemCopy = _selectedItem;
      _showDropdown = true;
    });
  }

  void _handleSelect(String? value) {
    setState(() {
      _selectedItemCopy = value!;
    });
  }

  void _handleDropdownOk() {
    setState(() {
      _selectedItem = _selectedItemCopy;
      _selectedItemCopy = '';
      _showDropdown = false;
    });
  }

  void _handleDropdownCancel() {
    setState(() {
      _selectedItemCopy = '';
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
      child: Stack(
        children: [
          GestureDetector(
            onTap: _handleDropdown,
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
                      _showDropdown ? _selectedItemCopy : _selectedItem,
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
            SelectDropdownList(
              title: widget.title,
              selectedValue: _selectedItemCopy,
              list: _list,
              selectHandler: _handleSelect,
              okHandler: _handleDropdownOk,
              cancelHandler: _handleDropdownCancel,
            ),
        ],
      ),
    );
  }
}
