// https://www.kindacode.com/article/how-to-create-accordions-in-flutter-without-plugins/
// accordion.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whereisit/shared/bloc/edit_item/edit_item_bloc.dart';
import 'package:whereisit/shared/widgets/accordian/accordian.view.dart';

class FilterAccordian extends StatefulWidget {
  final String title;
  final List<String> content;
  final bool? isEditable;
  final bool? isOnlyCategory;

  const FilterAccordian({
    super.key,
    required this.title,
    required this.content,
    this.isEditable,
    this.isOnlyCategory,
  });

  @override
  State<FilterAccordian> createState() => _FilterAccordianState();
}

class _FilterAccordianState extends State<FilterAccordian> {
  var isAccordianOpen = false;

  void handleAccordianItemTap(BuildContext context, int itemIndex) {
    BlocProvider.of<EditItemBloc>(context).add(
      EditItemSubcategorySelect({widget.title: widget.content[itemIndex]}),
    );
  }

  List<Widget> buildAccordianList() {
    var columnList = <Widget>[];
    for (var index = 0; index < widget.content.length; index++) {
      columnList.add(
        InkWell(
          onTap: () => handleAccordianItemTap(context, index),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 8.0,
              right: 16.0,
              bottom: 8.0,
              left: 32.0,
            ),
            child: widget.isEditable != null && widget.isEditable!
                ? TextFormField(
                    onChanged: (value) {
                      BlocProvider.of<EditItemBloc>(context).add(
                        EditItemSubcategoryChange({
                          '$index:${widget.title}': value,
                        }),
                      );
                    },
                    initialValue: widget.content[index],
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Sub category ${index + 1}',
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(widget.content[index]),
                  ),
          ),
        ),
      );
    }

    return columnList;
  }

  void handleAccordianTitleTap(BuildContext context) {
    widget.isOnlyCategory == null || !widget.isOnlyCategory!
        ? toggleAccordian()
        : () => BlocProvider.of<EditItemBloc>(context).add(
              EditItemCategorySelect(widget.title),
            );
  }

  Widget? buildAccordianTitle() {
    if (widget.isEditable != null && widget.isEditable!) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          onChanged: (value) {
            BlocProvider.of<EditItemBloc>(context).add(
              EditItemCategoryChange({widget.title: value}),
            );
          },
          initialValue: widget.title,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Category',
          ),
        ),
      );
    }

    return Text(widget.title);
  }

  Widget? buildAccordianTitleTrailingIcon() {
    if (widget.isOnlyCategory == null || !widget.isOnlyCategory!) {
      return Icon(
        isAccordianOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
      );
    }

    return null;
  }

  void toggleAccordian() {
    setState(() {
      isAccordianOpen = !isAccordianOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Accordian(
      buildAccordianList: buildAccordianList,
      buildAccordianTitle: buildAccordianTitle,
      buildAccordianTitleTrailingIcon: buildAccordianTitleTrailingIcon,
      handleAccordianTitleTap: handleAccordianTitleTap,
      isAccordianOpen: isAccordianOpen,
    );
  }
}
