import 'package:flutter/material.dart';
import 'package:whereisit/models/multi_select_dropdown_data.model.dart';

class MultiSelectDropdownList extends StatelessWidget {
  final double height;
  final double width;
  final List<MultiSelectDropdownData> list;
  final void Function(int, bool) checkboxHandler;

  const MultiSelectDropdownList({
    Key? key,
    required this.list,
    required this.checkboxHandler,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: height,
      ),
      child: Card(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: ((context, index) {
            return Row(
              children: [
                Checkbox(
                  value: list[index].isSelected,
                  onChanged: (bool? value) {
                    checkboxHandler(index, value!);
                  },
                ),
                Text(list[index].value),
              ],
            );
          }),
        ),
      ),
    );
  }
}
