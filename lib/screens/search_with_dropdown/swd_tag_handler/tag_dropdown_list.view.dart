import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/models/tag.model.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';

class TagDropdownList extends StatelessWidget {
  final void Function(String) handleNew;
  final void Function(String) handleSelect;

  const TagDropdownList({
    Key? key,
    required this.handleNew,
    required this.handleSelect,
  }) : super(key: key);

  Widget _alertDialog(BuildContext context, Tag? tag) {
    var deleteButton = TextButton(
      onPressed: () {
        if (tag != null) {
          BlocProvider.of<EditItemBloc>(context).add(
            EditItemTagDelete(tag),
          );
        }
        Navigator.of(context).pop();
      },
      child: const Text("DELETE"),
    );

    var doNotDeleteButton = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text("DO NOT DELETE"),
    );

    return AlertDialog(
      title: const Text('Are you sure?'),
      content: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          children: <TextSpan>[
            const TextSpan(
              text: 'Do you want to permanently delete the ',
            ),
            TextSpan(
              text: '"${tag != null ? tag.item : ""}"',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(text: ' tag?'),
          ],
        ),
      ),
      actions: <Widget>[
        doNotDeleteButton,
        deleteButton,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: BlocBuilder<EditItemBloc, EditItemState>(
        builder: (context, state) {
          if (state is EditItemTagToggleSuccess) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.item.uiTagsList != null
                  ? state.item.uiTagsList!.length
                  : 0,
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
                          value:
                              state.item.uiTagsList![index].isSelected ?? false,
                          onChanged: (bool? value) {
                            var tempList = state.item.uiTagsList ?? [];
                            var temp = tempList[index];
                            tempList[index] = Tag(
                              isNew: temp.isNew,
                              item: temp.item,
                              isSelected: value,
                              value: temp.value,
                            );
                            temp = tempList[index];

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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: GestureDetector(
                            onTap: () => handleSelect(
                              state.item.uiTagsList != null
                                  ? state.item.uiTagsList![index].item
                                  : '',
                            ),
                            child: Text(
                              state.item.uiTagsList != null
                                  ? state.item.uiTagsList![index].item
                                  : '',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => _alertDialog(
                            context,
                            state.item.uiTagsList != null
                                ? state.item.uiTagsList![index]
                                : null,
                          ),
                        ),
                        icon: const Icon(
                          Icons.delete_rounded,
                          color: Colors.red,
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
              itemCount: state.item.uiTagsList != null
                  ? state.item.uiTagsList!.length
                  : 0,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                  ),
                  child: state.item.uiTagsList != null &&
                          state.item.uiTagsList![index].isNew
                      ? GestureDetector(
                          onTap: () =>
                              BlocProvider.of<EditItemBloc>(context).add(
                            EditItemTagAdd(
                              state.item.uiTagsList != null
                                  ? state.item.uiTagsList![index]
                                  : null,
                            ),
                          ),
                          child: Text(
                            state.item.uiTagsList != null
                                ? state.item.uiTagsList![index].item
                                : '',
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
                                value: state.item.uiTagsList != null &&
                                        state.item.uiTagsList![index]
                                                .isSelected !=
                                            null
                                    ? state.item.uiTagsList![index].isSelected!
                                    : false,
                                onChanged: (bool? value) {
                                  var tempList = state.item.uiTagsList != null
                                      ? state.item.uiTagsList!
                                      : [];
                                  var temp = tempList[index];
                                  tempList[index] = Tag(
                                    isNew: temp.isNew,
                                    item: temp.item,
                                    isSelected: value,
                                    value: temp.value,
                                  );
                                  temp = tempList[index];

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
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: GestureDetector(
                                  onTap: () => handleSelect(
                                    state.item.uiTagsList != null
                                        ? state.item.uiTagsList![index].item
                                        : '',
                                  ),
                                  child: Text(
                                    state.item.uiTagsList != null
                                        ? state.item.uiTagsList![index].item
                                        : '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => showDialog(
                                context: context,
                                builder: (context) => _alertDialog(
                                  context,
                                  state.item.uiTagsList != null
                                      ? state.item.uiTagsList![index]
                                      : null,
                                ),
                              ),
                              icon: const Icon(
                                Icons.delete_rounded,
                                color: Colors.red,
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
