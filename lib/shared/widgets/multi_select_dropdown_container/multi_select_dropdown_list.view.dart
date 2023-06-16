import 'package:flutter/material.dart';
import 'package:whereisit/models/multi_select_dropdown_data.model.dart';

class MultiSelectDropdownList extends StatelessWidget {
  final List<MultiSelectDropdownData> list;
  final void Function(int, bool) checkboxHandler;
  final void Function() okHandler;
  final void Function() cancelHandler;

  const MultiSelectDropdownList({
    Key? key,
    required this.list,
    required this.checkboxHandler,
    required this.okHandler,
    required this.cancelHandler,
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
          return Card(
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            elevation: 5,
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
                              if (value != null) checkboxHandler(index, value);
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
                          onPressed: okHandler,
                          child: const Text('OK'),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: cancelHandler,
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
