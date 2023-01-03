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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DraggableScrollableSheet(
        initialChildSize: .65,
        minChildSize: .65,
        maxChildSize: .65,
        builder: (_, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: ((__, index) {
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
                const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Select Tags',
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('OK'),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text('CANCEL'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
