import 'package:flutter/material.dart';
import 'package:whereisit/models/multi_select_dropdown_data.model.dart';

class MultiSelectDropdownList extends StatelessWidget {
  final List<MultiSelectDropdownData> list;
  final void Function(int, bool) checkboxHandler;

  const MultiSelectDropdownList({
    Key? key,
    required this.list,
    required this.checkboxHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
