import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/models/list_item.model.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';

class DropdownList extends StatelessWidget {
  final List<ListItem> list;
  final void Function(String) handleNew;
  final void Function(String) handleSelect;

  const DropdownList({
    Key? key,
    required this.list,
    required this.handleNew,
    required this.handleSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: BlocBuilder<EditItemBloc, EditItemState>(
        builder: (context, state) {
          if (state is EditItemToggleTagSuccess) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.tags.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                    bottom: 16.0,
                  ),
                  child: list[index].isNew
                      ? Row(
                          children: [
                            Checkbox(
                              value: state.tags[index].isSelected,
                              onChanged: (bool? value) {
                                var temp = state.tags[index];
                                state.tags[index] = ListItem(
                                  isNew: temp.isNew,
                                  item: temp.item,
                                  isSelected: value,
                                  value: temp.value,
                                );
                                EditItemToggleTag(state.tags[index]);
                              },
                            ),
                            GestureDetector(
                              onTap: () =>
                                  handleNew(list[index].value as String),
                              child: Text(
                                list[index].item,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        )
                      : GestureDetector(
                          onTap: () => handleSelect(list[index].item),
                          child: Text(
                            list[index].item,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
