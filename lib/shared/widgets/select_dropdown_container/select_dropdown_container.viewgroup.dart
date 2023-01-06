import 'package:flutter/material.dart';
import 'package:whereisit/shared/widgets/select_dropdown_container/select_dropdown_list.view.dart';

class SelectDropdownContainer extends StatefulWidget {
  final double padding;

  const SelectDropdownContainer({
    Key? key,
    required this.padding,
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
  var _list = <String>[];

  void _handleDropdownOk() {}
  void _handleDropdownCancel() {}

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
            onTap: () {},
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
                    child: const Text(
                      'adasd',
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
              list: _list,
              okHandler: _handleDropdownOk,
              cancelHandler: _handleDropdownCancel,
            ),
        ],
      ),
    );
  }
}
