import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/models/ui_tag.model.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/widgets/pill_tag.view.dart';

class SharedMethods {
  List<Widget> buildTagsList(List<UiTag> tags, BuildContext context) {
    var pillTagsList = <Widget>[];
    for (var element in tags) {
      if (element.isSelected != null && element.isSelected!) {
        pillTagsList.add(
          PillTag(
            title: '#${element.item}',
            isShort: false,
            hasDelete: true,
            handleDelete: () => BlocProvider.of<EditItemBloc>(context).add(
              EditItemTagRemove(element.item),
            ),
          ),
        );
      }
    }

    return pillTagsList;
  }
}
