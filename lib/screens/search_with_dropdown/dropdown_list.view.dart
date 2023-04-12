import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/models/tag.model.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';

class DropdownList extends StatelessWidget {
  final void Function(String) handleNew;
  final void Function(String) handleSelect;

  const DropdownList({
    Key? key,
    required this.handleNew,
    required this.handleSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: BlocBuilder<EditItemBloc, EditItemState>(
        builder: (context, state) {
          if (state is EditItemTagToggleSuccess) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.tags.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: state.tags[index].isSelected ?? false,
                          onChanged: (bool? value) {
                            var tempList = state.tags;
                            var temp = tempList[index];
                            tempList[index] = Tag(
                              isNew: temp.isNew,
                              item: temp.item,
                              isSelected: value,
                              value: temp.value,
                            );

                            if (value != null) {
                              if (value) {
                                BlocProvider.of<EditItemBloc>(context).add(
                                  EditItemTagUpdateCount(1),
                                );
                              } else {
                                BlocProvider.of<EditItemBloc>(context).add(
                                  EditItemTagUpdateCount(-1),
                                );
                              }
                            }

                            BlocProvider.of<EditItemBloc>(context).add(
                              EditItemTagToggle(temp),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: GestureDetector(
                          onTap: () => handleSelect(state.tags[index].item),
                          child: Text(
                            state.tags[index].item,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is EditItemTagSearchSuccess) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.tags.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                  ),
                  child: state.tags[index].isNew
                      ? GestureDetector(
                          onTap: () =>
                              BlocProvider.of<EditItemBloc>(context).add(
                            EditItemTagAdd(
                              state.tags[index],
                            ),
                          ),
                          child: Text(
                            state.tags[index].item,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: state.tags[index].isSelected ?? false,
                                onChanged: (bool? value) {
                                  var tempList = state.tags;
                                  var temp = tempList[index];
                                  tempList[index] = Tag(
                                    isNew: temp.isNew,
                                    item: temp.item,
                                    isSelected: value,
                                    value: temp.value,
                                  );

                                  if (value != null) {
                                    if (value) {
                                      BlocProvider.of<EditItemBloc>(context)
                                          .add(
                                        EditItemTagUpdateCount(1),
                                      );
                                    } else {
                                      BlocProvider.of<EditItemBloc>(context)
                                          .add(
                                        EditItemTagUpdateCount(-1),
                                      );
                                    }
                                  }

                                  BlocProvider.of<EditItemBloc>(context).add(
                                    EditItemTagToggle(temp),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: GestureDetector(
                                onTap: () =>
                                    handleSelect(state.tags[index].item),
                                child: Text(
                                  state.tags[index].item,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
